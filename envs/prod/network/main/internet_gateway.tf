# /// コストインパクト低のため、削除不要 ///
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = aws_vpc.this.tags.Name
  }
}
