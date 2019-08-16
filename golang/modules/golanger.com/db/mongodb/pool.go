package mongodb

import (
	"context"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"go.mongodb.org/mongo-driver/mongo/readpref"
)

type Mongoer interface {
	M() *Mongo
	Client() *mongo.Client
	C(col bson.M) *Collection
	Col(col bson.M) *mongo.Collection
	Connect(ctx context.Context)
	Ping(ctx context.Context, rp *readpref.ReadPref)
	Disconnect(ctx context.Context)
	Close(ctx context.Context)
}

func NewMongoPool(poolType, name string, maxPoolSize int, opts ...*options.ClientOptions) (mr Mongoer) {
	switch poolType {
	case "ring":
		mr = Mongoer(NewMongoRingPool(name, maxPoolSize, opts...))
	case "chan":
		mr = Mongoer(NewMongoChanPool(name, maxPoolSize, opts...))
	default:
		mr = Mongoer(NewMongo(name, opts...))
	}

	return
}
