resource "aws_s3_bucket" "finance"{
  bucket = "finance-210"
  tags = {
    Description = "Finanace and payroll"
  }
}


resource "aws_s3_bucket_object" "finance-21010" {
  content = "/root/finance/finance-21010.doc"
  key   = "finance-21010.doc"
  bucket = aws_s3_bucket.finance.id
}

data "aws_iam_group" "finance-data"{
  group_name = "finance-analysts"
}

resource "aws_s3_bucket_policy" "finance-policy"{
  bucket = aws_s3_bucket.finance.id
  policy = << EOF
  { 
    //......
  }
  EOF
}

