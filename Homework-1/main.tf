resource "aws_iam_group" "blackpink" {
  name = "blackpink"
}

resource "aws_iam_group" "twice" {
  name = "twice"
}

resource "aws_iam_user" "jenny"  { name = "jenny" }
resource "aws_iam_user" "rose"   { name = "rose" }
resource "aws_iam_user" "lisa"   { name = "lisa" }
resource "aws_iam_user" "jisoo"  { name = "jisoo" }
resource "aws_iam_user" "jihyo"  { name = "jihyo" }
resource "aws_iam_user" "sana"   { name = "sana" }
resource "aws_iam_user" "momo"   { name = "momo" }
resource "aws_iam_user" "dahyun" { name = "dahyun" }

resource "aws_iam_user_group_membership" "blackpink_jenny" {
  user   = aws_iam_user.jenny.name
  groups = [aws_iam_group.blackpink.name]
}
resource "aws_iam_user_group_membership" "blackpink_rose" {
  user   = aws_iam_user.rose.name
  groups = [aws_iam_group.blackpink.name]
}
resource "aws_iam_user_group_membership" "blackpink_lisa" {
  user   = aws_iam_user.lisa.name
  groups = [aws_iam_group.blackpink.name]
}
resource "aws_iam_user_group_membership" "blackpink_jisoo" {
  user   = aws_iam_user.jisoo.name
  groups = [aws_iam_group.blackpink.name]
}

resource "aws_iam_user_group_membership" "twice_jihyo" {
  user   = aws_iam_user.jihyo.name
  groups = [aws_iam_group.twice.name]
}
resource "aws_iam_user_group_membership" "twice_sana" {
  user   = aws_iam_user.sana.name
  groups = [aws_iam_group.twice.name]
}
resource "aws_iam_user_group_membership" "twice_momo" {
  user   = aws_iam_user.momo.name
  groups = [aws_iam_group.twice.name]
}
resource "aws_iam_user_group_membership" "twice_dahyun" {
  user   = aws_iam_user.dahyun.name
  groups = [aws_iam_group.twice.name]
}

# Этих пользователей ты создаёшь вручную в AWS Console
# А потом импортируешь:
# terraform import aws_iam_user.miyeon miyeon
# terraform import aws_iam_user.mina mina

resource "aws_iam_user_group_membership" "miyeon_blackpink" {
  user   = aws_iam_user.miyeon.name
  groups = [aws_iam_group.blackpink.name]
}

resource "aws_iam_user_group_membership" "mina_twice" {
  user   = aws_iam_user.mina.name
  groups = [aws_iam_group.twice.name]
}


resource "aws_iam_user" "miyeon" {
  name = "miyeon"
}

resource "aws_iam_user" "mina" {
  name = "mina"
}