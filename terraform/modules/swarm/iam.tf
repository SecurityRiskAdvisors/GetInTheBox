##
# EBS
##

/* TODO: EBS encryption
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "ebs_policy" {
  statement {
    sid = "1"

    actions = [
      "kms:CreateGrant",
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:GenerateDataKey*",
      "kms:ReEncrypt*",
    ]

    principal = [
      data.aws_caller_identity.current.arn,
    ]
  }
}

##
# EC2
##

resource "aws_iam_role" "swarm_node_role" {
    name = "[${var.project}] Red Swarm Node Role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Sid = ""
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
            }
        ]
    })
}

resource "aws_iam_policy" "swarm_node_policy" {
    name = "[${var.project}] Red Swarm Node Policy"
    path = "/"
    description = "Permission set for Red Swarm EC2 nodes"
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Action = [
                    "kms:CreateGrant",
                    "kms:Decrypt",
                    "kms:DescribeKey",
                    "kms:GenerateDataKey*",
                    "kms:ReEncrypt*",
                ],
                Resource = ""
            }
        ]
    })
}
*/