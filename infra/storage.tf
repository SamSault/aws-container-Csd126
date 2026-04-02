resource "aws_s3_bucket" "myxpix-photos" {
    bucket = "xpix-photos-26-24052722"

    tags = {
      Name = "xpix-photos"
    }

  
  
}

resource "aws_dynamodb_table" "mydynamodb_table" {
    name = "xpix-photos"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "photo_id"
    stream_enabled = true
    stream_view_type = "NEW_IMAGE"

    attribute {
      name = "photo_id"
      type = "S"
    }

     attribute {
      name = "user_id"
      type = "S"
    }
     attribute {
      name = "upload_at"
      type = "S"
    }

     attribute {
      name = "feed_key"
      type = "S"
    }

    global_secondary_index {
      name = "user-photos-index"
      key_schema {
        attribute_name = "user_id"
        key_type = "HASH"
      }
        key_schema {
        attribute_name = "upload_at"
        key_type = "RANGE"
      }
    
      projection_type = "ALL"
    }

    
    global_secondary_index {
      name = "feed-index"
       key_schema {
        attribute_name = "feed_key"
        key_type = "HASH"
      }
        key_schema {
        attribute_name = "upload_at"
        key_type = "RANGE"
      }
      projection_type = "ALL"
    }


}

resource "aws_ssm_parameter" "photo_bucket" {
    name = "/app/s3/photos_bucket_name"
    type = "String"
    value = "bucket"
    overwrite = true


  
}

resource "aws_ssm_parameter" "photo_table" {
    name = "/app/dynamodb/photos_table_name"
    type = "String"
    value = "name"
    overwrite = true

  
}