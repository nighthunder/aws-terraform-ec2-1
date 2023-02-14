provider "aws"{
    region = "us-east-1"
    profile = "maya-terraform-source"
}

resource "aws_key_pair" "k8s-key"{
    key_name = "k8s-key"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCc+VAa7uZz2Kwu4ig5RFtvA2PKWAGpgFX4+ElSvuWracAgqJc8gruGIWpvGBZZ0s8Tod6iYDnh6jovxSXrFyvbV2HbiuLSHvd9aWOOyXBlgVqcrn+eQmqNPgqsBSKXdk9TLJGd49HJKzV6wvZtU+GoUTs54wmuCK+MrCE+dXnkbHEy3inhgTH/rvf7XFoB/kf632Ql9I4Q7IWuaeFZ4sQ6sk/2jYvPBQeiaXOTpjllapoP1qp7lVwWvv4GsfuLTfmyN3PQ6qCCgcgaUM2OYmbp71WF8L0MUzKCzkaV81ub1crAaMx/lu01FrQjk7NnXiF8NRrynRu6rGDtyN/PSh9ueI9Ty0/5UO7AcRAzirYtI+3zPWgxrMFk8n3UGairLeQWHVKP/rOSMy9gbLO2kQdi+sJfoTAg+Nj04rpKnsumXL5l2g8XuiyoqLiAjUGNpp+hucJwA3XWJQmUPZRZCs5vf4vHE8ocYa/bjwaBo48TgTWV8F1e0E9sdQHNTPRn818="
}

resource "aws_security_group" "k8s-sg"{

    ingress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        self = true
    }

    ingress{
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }    

    egress{
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 0
        to_port = 0
        protocol = -1
    }
}

resource "aws_instance" "kubernetes-worker"{
    ami = "ami-007868005aea67c54"
    instance_type = "t3.medium"
    key_name= "k8s-key"
    count = 2
    tags = {
        name = "k8s"
        type = "worker"
    }
    security_groups = ["${aws_security_group.k8s-sg.name}"]
}

resource "aws_instance" "kubernetes-master"{
    ami = "ami-007868005aea67c54"
    instance_type = "t3.medium"
    key_name= "k8s-key"
    count = 2
    tags = {
        name = "k8s"
        type = "master"
    }
    security_groups = ["${aws_security_group.k8s-sg.name}"]
}

