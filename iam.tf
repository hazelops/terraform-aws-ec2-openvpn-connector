# AWS SSM resources
resource "aws_iam_role" "this" {
  name               = "${var.env}-openvpn-connector"
  assume_role_policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = var.ssm_role_arn
}

resource "aws_iam_instance_profile" "this" {
  name = "${var.env}-openvpn-connector"
  role = aws_iam_role.this.name
}

data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"

    principals {
      type = "Service"

      identifiers = [
        "ec2.amazonaws.com",
        "ssm.amazonaws.com",
      ]
    }

    actions = ["sts:AssumeRole"]
  }
}
