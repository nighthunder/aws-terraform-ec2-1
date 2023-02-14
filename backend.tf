terraform{
    backend "s3"{
        region = "us-east-1"
        bucket = "k8s-backend-1-123"
        encrypt = "true"
        key = "terraform.tfstate"
        access_key = "AKIAVTO5Z6KXQGTFG3V6"
        secret_key = "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"
    }
} 