package mongodb

import (
	"container/ring"
	"context"
	"sync"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"go.mongodb.org/mongo-driver/mongo/readpref"
	"golanger.com/log"
)

type MongoRingPool struct {
	maxPoolSize int
	mongoRing   *ring.Ring
	mutex       sync.Mutex
	name        string
	opts        []*options.ClientOptions
}

func NewMongoRingPool(name string, maxPoolSize int, opts ...*options.ClientOptions) *MongoRingPool {
	m := &MongoRingPool{
		maxPoolSize: maxPoolSize,
		mongoRing:   ring.New(maxPoolSize),
		name:        name,
		opts:        opts,
	}

	log.Debug("<NewMongoRingPool> init mongo")
	m.createMongos()

	return m
}

func (m *MongoRingPool) createMongos() {
	for i := 0; i < m.maxPoolSize; i++ {
		m.mongoRing.Value = NewMongo(m.name, m.opts...)
		m.mongoRing = m.mongoRing.Next()
	}
}

func (m *MongoRingPool) M() *Mongo {
	m.mutex.Lock()
	defer m.mutex.Unlock()
	mon := m.mongoRing.Value.(*Mongo)
	m.mongoRing = m.mongoRing.Next()

	return mon
}

func (m *MongoRingPool) Client() *mongo.Client {
	mon := m.M()
	return mon.Client()
}

func (m *MongoRingPool) C(col bson.M) *Collection {
	return &Collection{
		m:   Mongoer(m),
		col: col,
	}
}

func (m *MongoRingPool) Col(col bson.M) *mongo.Collection {
	return m.M().Col(col)
}

func (m *MongoRingPool) Connect(ctx context.Context) {
	m.mutex.Lock()
	defer m.mutex.Unlock()
	for i := 0; i < m.maxPoolSize; i++ {
		m.mongoRing.Value.(*Mongo).Connect(ctx)
		m.mongoRing = m.mongoRing.Next()
	}
}

func (m *MongoRingPool) Ping(ctx context.Context, rp *readpref.ReadPref) {
	m.mutex.Lock()
	defer m.mutex.Unlock()
	for i := 0; i < m.maxPoolSize; i++ {
		m.mongoRing.Value.(*Mongo).Ping(ctx, rp)
		m.mongoRing = m.mongoRing.Next()
	}
}

func (m *MongoRingPool) ConnectDefault() {
	m.mutex.Lock()
	defer m.mutex.Unlock()
	for i := 0; i < m.maxPoolSize; i++ {
		m.mongoRing.Value.(*Mongo).Connect(context.Background())
		//判断服务是否可用
		m.mongoRing.Value.(*Mongo).Ping(context.Background(), readpref.Primary())
		m.mongoRing = m.mongoRing.Next()
	}
}

func (m *MongoRingPool) Disconnect(ctx context.Context) {
	m.mutex.Lock()
	defer m.mutex.Unlock()
	for i := 0; i < m.maxPoolSize; i++ {
		m.mongoRing.Value.(*Mongo).Disconnect(ctx)
		m.mongoRing = m.mongoRing.Next()
	}

	log.Debug("<MongoRingPool> disconnect all client of mongodb")
}

func (m *MongoRingPool) Close(ctx context.Context) {
	m.mutex.Lock()
	defer m.mutex.Unlock()
	for i := 0; i < m.maxPoolSize; i++ {
		m.mongoRing.Value.(*Mongo).Close(ctx)
		m.mongoRing = m.mongoRing.Next()
	}

	m.mongoRing = nil

	log.Debug("<MongoRingPool> close all client of mongodb")
}
