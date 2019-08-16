package model

import (
	"context"
	"time"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"golanger.com/db/mongodb"
)

/*
"log_sender": { //发送器日志集
	"_id": "id",
	"sender": {
		"ip": "ip",
		"object": "object"
	},
	"received": { //已经接收过
		"ip": "ip", //received_object的ip，如receiver_mta_ip
		"object": "object" //如mail的邮箱接收者的域名(fook@163.com的163.com)：receiver_domain等等作为received_object
	},
	"relay": {
		"uri": "uri", //域名,请求路径等等，如:smtp_domain
		"client": "client" //username,client_id等等，如:smtp_username
	},
	"client": "client", //客户端标识，如：client_id等
	"received_id": "received_id",
	"data": "@notify_data",
	"source_data": "source_data",
	"response_code": "response_code",
	"response_message": "response_message",
	"create_time": "create_time"
}
*/

var (
	ColLogSender = bson.M{
		"name": "log_sender",
		"index": []mongo.IndexModel{
			{
				bson.D{
					{"data.type", 1},
				},
				options.Index().SetBackground(true),
			},
			{
				bson.D{
					{"response_code", 1},
					{"create_time", -1},
				},
				options.Index().SetBackground(true),
			},
		},
	}
)

type LogSenderSenderObject struct {
	IP     string `json:"ip" bson:"ip"`
	Object string `json:"object" bson:"object"`
}

type LogSenderReceiverObject struct {
	IP     string `json:"ip" bson:"ip"`
	Object string `json:"object" bson:"object"`
}

type LogSenderRelay struct {
	URI    string `json:"uri" bson:"uri"`
	Client string `json:"client" bson:"client"`
}

type LogSender struct {
	ID              primitive.ObjectID      `field:"id" json:"_id" bson:"_id,omitempty"`
	SenderObject    LogSenderSenderObject   `field:"sender_object,omitempty" json:"sender_object" bson:"sender_object"`       //发送者对象信息，这里是指发送者，如果发送者是由自己发送，那也可以等同于发送器的对象信息
	ReceiverObject  LogSenderReceiverObject `field:"receiver_object,omitempty" json:"receiver_object" bson:"receiver_object"` //接收者对象信息，这里是指接收者，并不是程序的接收器
	Relay           LogSenderRelay          `field:"relay" json:"relay" bson:"relay"`
	Client          string                  `field:"client" json:"client" bson:"client"`
	ReceivedID      primitive.ObjectID      `field:"received_id" json:"received_id" bson:"received_id"`
	Data            NotifyData              `field:"data" json:"data" bson:"data"` //复用NotifyData的类型
	SourceData      string                  `field:"source_data" json:"source_data" bson:"source_data"`
	ResponseCode    string                  `field:"response_code" json:"response_code" bson:"response_code"`
	ResponseMessage string                  `field:"response_message" json:"response_message" bson:"response_message"`
	CreateTime      time.Time               `field:"create_time" json:"create_time" bson:"create_time"`
	UpdateTime      time.Time               `field:"update_time" json:"update_time" bson:"update_time"`
}

func LogSenderFilterByID(id primitive.ObjectID) bson.D {
	return bson.D{
		{"_id", id},
	}
}

func LogSenderFilterByData(data string) bson.D {
	return bson.D{{"data", data}}
}

func LogSenderProjectionOneID() *options.FindOneOptions {
	return options.FindOne().SetProjection(bson.D{
		{"_id", 1},
	})
}

func LogSenderDeleteOne(ctx context.Context, mgo mongodb.Mongoer, filter bson.D, opts ...*options.DeleteOptions) (*mongo.DeleteResult, error) {
	return mgo.Col(ColLogSender).DeleteOne(ctx, filter, opts...)
}

func LogSenderFindOne(ctx context.Context, mgo mongodb.Mongoer, filter bson.D, opts ...*options.FindOneOptions) (m *LogSender, err error) {
	err = mgo.Col(ColLogSender).FindOne(ctx, filter, opts...).Decode(&m)
	return
}

func LogSenderFind(ctx context.Context, mgo mongodb.Mongoer, filter bson.D, opts ...*options.FindOptions) (*mongo.Cursor, error) {
	return mgo.Col(ColLogSender).Find(ctx, filter, opts...)
}

func LogSenderUpdateOne(ctx context.Context, mgo mongodb.Mongoer, filter, update bson.D, opts ...*options.UpdateOptions) (*mongo.UpdateResult, error) {
	update = append(update, bson.E{"$set", bson.D{
		{"update_time", time.Now()},
	}})

	return mgo.Col(ColLogSender).UpdateOne(ctx, filter, update, opts...)
}

func LogSenderAggregate(ctx context.Context, mgo mongodb.Mongoer, pipeline bson.D, opts ...*options.AggregateOptions) (*mongo.Cursor, error) {
	return mgo.Col(ColLogSender).Aggregate(ctx, pipeline, opts...)
}

func LogSenderCount(ctx context.Context, mgo mongodb.Mongoer, filter bson.D, opts ...*options.CountOptions) (int64, error) {
	return mgo.Col(ColLogSender).CountDocuments(ctx, filter, opts...)
}

func LogSenderUpdate(ctx context.Context, mgo mongodb.Mongoer, filter, update bson.D, opts ...*options.UpdateOptions) (*mongo.UpdateResult, error) {
	update = append(update, bson.E{"$setOnInsert", bson.D{
		{"create_time", time.Now()},
	}})

	return LogSenderUpdateOne(ctx, mgo, filter, update, options.MergeUpdateOptions(opts...).SetUpsert(true))
}

func LogSenderSet(ctx context.Context, mgo mongodb.Mongoer, filter, data bson.D, opts ...*options.UpdateOptions) (*mongo.UpdateResult, error) {
	update := bson.D{
		{"$set", data},
	}

	return LogSenderUpdate(ctx, mgo, filter, update, opts...)
}

func LogSenderInsert(ctx context.Context, mgo mongodb.Mongoer, filter, data bson.D, opts ...*options.UpdateOptions) (*mongo.UpdateResult, error) {
	update := bson.D{
		{"$addToSet", data},
	}

	return LogSenderUpdate(ctx, mgo, filter, update, opts...)
}

func LogSenderSetAndInsert(ctx context.Context, mgo mongodb.Mongoer, filter, setData, insertData bson.D, opts ...*options.UpdateOptions) (*mongo.UpdateResult, error) {
	update := bson.D{
		{"$set", setData},
		{"$addToSet", insertData},
	}

	return LogSenderUpdate(ctx, mgo, filter, update, opts...)
}

func LogSenderPull(ctx context.Context, mgo mongodb.Mongoer, filter, deleteFilters bson.D, opts ...*options.UpdateOptions) (*mongo.UpdateResult, error) {
	update := bson.D{
		{"$pull", deleteFilters},
	}
	return LogSenderUpdateOne(ctx, mgo, filter, update, opts...)
}

func LogSenderCreate(ctx context.Context, mgo mongodb.Mongoer, m *LogSender, opts ...*options.InsertOneOptions) (*mongo.InsertOneResult, error) {
	if m.ID == primitive.NilObjectID {
		m.ID = primitive.NewObjectID()
	}

	if m.CreateTime.IsZero() {
		m.CreateTime = time.Now()
	}

	if m.UpdateTime.IsZero() {
		m.UpdateTime = time.Now()
	}

	doc := bson.D{
		{"_id", m.ID},
		{"sender_object", m.SenderObject},
		{"received_object", m.ReceiverObject},
		{"relay", m.Relay},
		{"client", m.Client},
		{"received_id", m.ReceivedID},
		{"data", m.Data},
		{"source_data", m.SourceData},
		{"response_code", m.ResponseCode},
		{"response_message", m.ResponseMessage},
		{"create_time", m.CreateTime},
		{"update_time", m.UpdateTime},
	}

	return mgo.Col(ColLogSender).InsertOne(ctx, doc, opts...)
}
