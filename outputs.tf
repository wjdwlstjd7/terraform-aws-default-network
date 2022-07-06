# Network outputs
output "vpc_id" {
  value = aws_vpc.main.*.id
}
output "public_subnet_ids" {
  value = aws_subnet.public.*.id
}
output "ap_subnet_ids" {
  value = aws_subnet.app.*.id
}
output "db_subnet_ids" {
  value = aws_subnet.db.*.id
}
output "ap_route_table" {
  value = aws_route_table.app.*.id
}
output "db_route_table" {
  value = aws_route_table.db.*.id
}
output "azs" {
  value = var.azs
}