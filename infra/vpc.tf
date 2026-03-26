resource "aws_vpc" "asmt" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "lab2-vpc"
  }
}

import {
  to = aws_vpc.asmt
  id = "vpc-05aecebd30175f50f"
}

# -------------------------
# Public Subnets
# -------------------------

resource "aws_subnet" "az1_public" {
  vpc_id            = aws_vpc.asmt.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.1.0/24"

  tags = {
    Name = "project-subnet-public1-us-east-1a"
  }
}

import {
  to = aws_subnet.az1_public
  id = "subnet-02155d5e24729afc8"
}

resource "aws_subnet" "public_2" {
  vpc_id            = aws_vpc.asmt.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.0.2.0/24"

  tags = {
    Name = "project-subnet-public2-us-east-1b"
  }
}

import {
  to = aws_subnet.public_2
  id = "subnet-0bc1d2421f2361d53"
}

# -------------------------
# Private Subnets
# -------------------------

resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.asmt.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.3.0/24"

  tags = {
    Name = "project-subnet-private1-us-east-1a"
  }
}

import {
  to = aws_subnet.private_1
  id = "subnet-0be5fa823d955a240"
}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.asmt.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.0.4.0/24"

  tags = {
    Name = "project-subnet-private2-us-east-1b"
  }
}

import {
  to = aws_subnet.private_2
  id = "subnet-02e83a4f5b1376194"
}

# -------------------------
# Internet Gateway
# -------------------------

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.asmt.id

  tags = {
    Name = "project-igw"
  }
}

import {
  to = aws_internet_gateway.igw
  id = "igw-0ffd725dd5fab7448"
}

# -------------------------
# Route Tables
# -------------------------

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.asmt.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "project-rtb-public"
  }
}

import {
  to = aws_route_table.public
  id = "rtb-0970a41619b057c84"
}

resource "aws_route_table" "private_rt1" {
  vpc_id = aws_vpc.asmt.id

  tags = {
    Name = "project-rtb-private1-us-east-1a"
  }
}

import {
  to = aws_route_table.private_rt1
  id = "rtb-04c6814964d496aa3"
}

resource "aws_route_table" "private_rt2" {
  vpc_id = aws_vpc.asmt.id

  tags = {
    Name = "project-rtb-private2-us-east-1b"
  }
}

import {
  to = aws_route_table.private_rt2
  id = "rtb-0cbef06d03c4ae372"
}

# -------------------------
# Route Table Associations
# -------------------------

resource "aws_route_table_association" "public_asc1" {
  subnet_id      = aws_subnet.az1_public.id
  route_table_id = aws_route_table.public.id
}

import {
  to = aws_route_table_association.public_asc1
  id = "subnet-02155d5e24729afc8/rtb-0970a41619b057c84"
}

resource "aws_route_table_association" "public_asc2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}

import {
  to = aws_route_table_association.public_asc2
  id = "subnet-0bc1d2421f2361d53/rtb-0970a41619b057c84"
}

resource "aws_route_table_association" "private_asc1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_rt1.id
}

import {
  to = aws_route_table_association.private_asc1
  id = "subnet-0be5fa823d955a240/rtb-04c6814964d496aa3"
}

resource "aws_route_table_association" "private_asc2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private_rt2.id
}

import {
  to = aws_route_table_association.private_asc2
  id = "subnet-02e83a4f5b1376194/rtb-0cbef06d03c4ae372"
}

# -------------------------
# Security Group
# -------------------------

resource "aws_security_group" "sc_group" {
  name        = "xpix-app-server"
  description = "allow XPix app server connections"
  vpc_id      = aws_vpc.asmt.id
}

import {
  to = aws_security_group.sc_group
  id = "sg-0c472dd4401cf26fc"
}

# -------------------------
# Security Group Rule
# -------------------------

resource "aws_vpc_security_group_ingress_rule" "sc_rule" {
  security_group_id = aws_security_group.sc_group.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
}

import {
  to = aws_vpc_security_group_ingress_rule.sc_rule
  id = "sgr-06e40951181a38581"
}