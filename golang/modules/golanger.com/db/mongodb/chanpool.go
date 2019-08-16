package mongodb

import (
	"context"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"go.mongodb.org/mongo-driver/mongo/readpref"
	"golanger.com/log"
)

type MongoChanPool struct {
	maxPoolSize int
	mongoChan   chan *Mongo
	name        string
	opts        []*options.ClientOptions
}

func NewMongoChanPool(name string, maxPoolSize int, opts ...*options.ClientOptions) *MongoChanPool {
	m := &MongoChanPool{
		maxPoolSize: maxPoolSize,
		mongoChan:   make(chan *Mongo, maxPoolSize),
		name:        name,
		opts:        opts,
	}

	log.Debug("<NewMongoChanPool> init mongo")
	m.createMongos()

	return m
}

func (m *MongoChanPool) createMongos() {
	for i := 0; i < m.maxPoolSize; i++ {
		m.mongoChan <- NewMongo(m.name, m.opts...)
	}
}

func (m *MongoChanPool) M() *Mongo {
	mon := <-m.mongoChan
	m.mongoChan <- NewMongo(m.name, m.opts...)
	return mon
}

func (m *MongoChanPool) Client() *mongo.Client {
	mon := m.M()
	return mon.Client()
}

func (m *MongoChanPool) C(col bson.M) *Collection {
	return &Collection{
		m:   Mongoer(m),
		col: col,
	}
}

func (m *MongoChanPool) Col(col bson.M) *mongo.Collection {
	return m.M().Col(col)
}

func (m *MongoChanPool) Connect(ctx context.Context) {
	for i := 0; i < len(m.mongoChan); i++ {
		mon := <-m.mongoChan
		mon.Connect(ctx)
	}
}

func (m *MongoChanPool) Ping(ctx context.Context, rp *readpref.ReadPref) {
	for i := 0; i < len(m.mongoChan); i++ {
		mon := <-m.mongoChan
		mon.Ping(ctx, rp)
	}
}

func (m *MongoChanPool) ConnectDefault() {
	for i := 0; i < len(m.mongoChan); i++ {
		mon := <-m.mongoChan
		mon.Connect(context.Background())
		//判断服务是否可用
		mon.Ping(context.Background(), readpref.Primary())
	}
}

func (m *MongoChanPool) Disconnect(ctx context.Context) {
	for i := 0; i < len(m.mongoChan); i++ {
		mon := <-m.mongoChan
		mon.Disconnect(ctx)
	}

	log.Debug("<MongoChanPool> disconnect all client of mongodb")
}

func (m *MongoChanPool) Close(ctx context.Context) {
	for i := 0; i < len(m.mongoChan); i++ {
		mon := <-m.mongoChan
		mon.Close(ctx)
	}

	close(m.mongoChan)

	log.Debug("<MongoChanPool> close all client of mongodb")
}
