package mongodb

import (
	"context"
	"encoding/gob"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"go.mongodb.org/mongo-driver/mongo/readpref"
	"golanger.com/log"
)

func init() {
	gob.Register(bson.M{})
}

type Collection struct {
	m   Mongoer
	col bson.M
}

func (c *Collection) C() *mongo.Collection {
	return c.m.M().Col(c.col)
}

type Mongo struct {
	database string
	client   *mongo.Client
	colNames map[string]*mongo.Collection
	opts     []*options.ClientOptions
}

func NewMongo(name string, opts ...*options.ClientOptions) *Mongo {
	m := &Mongo{
		database: name,
		colNames: map[string]*mongo.Collection{},
		opts:     opts,
	}

	mClient, err := mongo.NewClient(opts...)
	if err != nil {
		log.Fatal("<NewMongo> ", "mongo.NewClient error:", err)
	}

	m.client = mClient
	m.ConnectDefault()

	return m
}

func (m *Mongo) M() *Mongo {
	return m
}

func (m *Mongo) Client() *mongo.Client {
	return m.client
}

func (m *Mongo) C(col bson.M) *Collection {
	return &Collection{
		m:   Mongoer(m),
		col: col,
	}
}

func (m *Mongo) Col(col bson.M) *mongo.Collection {
	if colName, ok := col["name"].(string); ok {
		if _, ok := m.colNames[colName]; !ok {
			m.colNames[colName] = m.client.Database(m.database).Collection(colName)

			if _, okIn := col["index"]; okIn {
				if colIndexs, okType := col["index"].([]mongo.IndexModel); okType {
					m.colNames[colName].Indexes().CreateMany(context.Background(), colIndexs)
				}
			} else {
				m.colNames[colName].Database().RunCommand(context.Background(), bson.D{
					{"create", colName},
				})
			}
		}

		return m.colNames[colName]
	}

	return nil
}

func (m *Mongo) Connect(ctx context.Context) {
	if err := m.client.Connect(context.Background()); err != nil {
		log.Fatal("<ConnectDefault> ", "mongo.Connect error:", err)
	}
}

func (m *Mongo) Ping(ctx context.Context, rp *readpref.ReadPref) {
	if err := m.client.Ping(ctx, rp); err != nil {
		log.Fatal("<ConnectDefault> ", "mongo.Ping error:", err)
	}
}

func (m *Mongo) ConnectDefault() {
	m.Connect(context.Background())

	//判断服务是否可用
	m.Ping(context.Background(), readpref.Primary())
}

func (m *Mongo) Disconnect(ctx context.Context) {
	m.client.Disconnect(ctx)
}

func (m *Mongo) Close(ctx context.Context) {
	m.client.Disconnect(ctx)
	m = nil
}
