
# dependecies
1. ruby > 2.3.7
2. grpc
3. google-protobuf

# Hash to Grpc object converter

This is a simple library to convert a hash to grpc object

eg.


 Sample Proto file (.proto) :

       syntax = "proto3";

        package cpqgrpc.product.v1;

        message ProductRequest {
          uint64 id = 2;
          string name = 3;
       }

      message ProductResp {
          uint64 id = 2;
          string name = 3;
       }

      service Product {
        rpc GetProduct (ProductRequest) returns (ProductResp);
      }


      Sample generated service (.rb):
        require 'google/protobuf'

        require 'cpqgrpc/custom_types_pb'
        Google::Protobuf::DescriptorPool.generated_pool.build do
           add_message "cpqgrpc.product.v1.ProductRequest" do
             optional :id, :uint64, 2
             repeated :name, :string, 3
           end
        end

        module Cpqgrpc
           module Product
               module V1
                   ProductRequest =    Google::Protobuf::DescriptorPool.generated_pool.lookup("cpqgrpc.product.v1.ProductRequest").msgclass
                   ProductResp = Google::Protobuf::DescriptorPool.generated_pool.lookup("cpqgrpc.product.v1.ProductResp").msgclass
               end
           end
        end

# Above are the sample generated protos
1. To convert hash { id: 1, name: 'Macbook' } to Grpc object Cpqgrpc::Product::V1::ProductRequest use below

   GrpcDataTransformers.hash_to_grpc_object( { id: 1, name: 'Macbook' })




