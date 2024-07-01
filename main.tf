

resource "aws_kendra_index" "this" {
  name        = "TFTest"
  description = "TF Testing"
  edition     = "DEVELOPER_EDITION"
  role_arn    = "arn:aws:iam::458891109543:role/service-role/AmazonKendra-us-east-1-ClickOps"

  tags = {
    "CreatedBY" = "Terraform"
  }
}

resource "aws_kendra_data_source" "this" {
  index_id      = aws_kendra_index.this.id
  name          = "TFTest"
  description   = "TF Testing"
  language_code = "en"
  type          = "S3"

  tags = {
    "CreatedBy" = "Terraform"
  }

  role_arn = "arn:aws:iam::458891109543:role/service-role/AmazonKendra-us-east-1-ClickOps"

  configuration {
    s3_configuration {
      bucket_name = "clickops-bu-tftesting-kendra"
      inclusion_prefixes = ["Palo-Alto-Docs"]
    }
  }

  custom_document_enrichment_configuration {
    inline_configurations {
      condition {
        condition_document_attribute_key = "_source_uri"
        operator = "Equals"
        
        condition_on_value {
          string_value = "Palo-Alto-Docs"
        }
      }

      target {
        target_document_attribute_key = "_category"
        target_document_attribute_value_deletion = false

        target_document_attribute_value {
          string_value = "Palo-Alto-Docs"
        }
      }

      document_content_deletion = false
    }

    inline_configurations {
      condition {
        condition_document_attribute_key = "_source_uri"
        operator = "Equals"
        
        condition_on_value {
          string_value = "Palo-Alto-Docs"
        }
      }

      target {
        target_document_attribute_key = "_source_uri"
        target_document_attribute_value_deletion = false

        target_document_attribute_value {
          string_value = "Palo-Alto-Docs"
        }
      }

      document_content_deletion = false
    }
  }
}
