data "aws_route53_zone" "root_hosted_zone" {
  provider     = aws.root
  name         = "${var.domain_name}"
  private_zone = false
}

resource "aws_route53_zone" "env_hosted_zone" {
  name = "${var.env}.${var.domain_name}"
}

resource "aws_route53_record" "delegation_record" {
  provider = aws.root
  zone_id  = data.aws_route53_zone.root_hosted_zone.zone_id
  name     = "${var.env}.${var.domain_name}"
  type     = "NS"
  ttl      = 180

  records = aws_route53_zone.env_hosted_zone.name_servers
}

resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
}

data "aws_iam_policy_document" "terraform_ci_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:STEFFENS-GITHUB/core-infrastructure:*"]
    }
  }
}

resource "aws_iam_role" "terraform_ci" {
  name               = "terraform-ci"
  assume_role_policy = data.aws_iam_policy_document.terraform_ci_trust.json
}

resource "aws_iam_role_policy_attachment" "terraform_ci" {
  role       = aws_iam_role.terraform_ci.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}