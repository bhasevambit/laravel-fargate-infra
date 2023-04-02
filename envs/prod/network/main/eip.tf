# /// コストインパクト「有」のため、不使用時は削除する事 ("terrafomrs apply -var='enable_nat_gateway=false'"によるオプション指定でも作成回避可能) ///
# resource "aws_eip" "nat_gateway" {
#   for_each = var.enable_nat_gateway ? local.nat_gateway_azs : {}

#   vpc = true

#   tags = {
#     Name = "${aws_vpc.this.tags.Name}-nat-gateway-${each.key}"
#   }
# }
