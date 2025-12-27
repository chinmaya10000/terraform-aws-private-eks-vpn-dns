resource "aws_security_group" "openvpn" {
  name        = "${local.env}-openvpn-sg"
  vpc_id      = module.vpc.vpc_id
  description = "Security group for OpenVPN server"

  tags = {
    Name = "${local.env}-openvpn-sg"
  }
}

resource "aws_vpc_security_group_egress_rule" "openvpn_allow_all" {
  security_group_id = aws_security_group.openvpn.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports

  tags = {
    Name = "allow-all"
  }
}

resource "aws_vpc_security_group_ingress_rule" "openvpn_allow_ssh_from_anywhere" {
  security_group_id = aws_security_group.openvpn.id
  cidr_ipv4         = "0.0.0.0/0" # Potensially limit to corporate IPs.
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22

  tags = {
    Name = "allow-ssh-from-anywhere"
  }
}

resource "aws_vpc_security_group_ingress_rule" "openvpn_allow_1194_from_anywhere" {
  security_group_id = aws_security_group.openvpn.id
  cidr_ipv4         = "0.0.0.0/0" # Potensially limit to corporate IPs.
  from_port         = 1194
  ip_protocol       = "udp"
  to_port           = 1194

  tags = {
    Name = "allow-1194-from-anywhere"
  }
}
