# /// コストインパクト「有」のため、不使用時は削除する事 ("terrafomrs apply -var='enable_nat_gateway=false'"によるオプション指定でも作成回避可能) ///
# resource "aws_nat_gateway" "this" {
#   for_each = var.enable_nat_gateway ? local.nat_gateway_azs : {}

#   allocation_id = aws_eip.nat_gateway[each.key].id
#   subnet_id     = aws_subnet.public[each.key].id

#   tags = {
#     Name = "${aws_vpc.this.tags.Name}-${each.key}"
#   }
# }
