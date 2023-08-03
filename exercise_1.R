getwd()


# 1
# 데이터 확인
library(ggplot2)
head(msleep)

# (1) bodywt-brainwt 산점도
plot(msleep$bodywt, msleep$brainwt, pch=17)

# (2) 로그 변환 후 산점도 + 회귀직선 그리기 + 제목 추가
plot(log(msleep$bodywt), log(msleep$brainwt), 
     main="202235-368052",
     xlab = "log(bodywt)", ylab = "log(brainwt)",
     pch=15)
abline(lm(log(msleep$brainwt) ~ log(msleep$bodywt)), col= "red", lwd=1)

# 2
# 데이터 확인
head(mpg)
summary(mpg)

# 데이터 준비
drv.data <- as.factor(mpg$drv)
str(drv.data)
hwy.data <- mpg$hwy
no <- c(1:234)
df <- data.frame(no, drv.data, hwy.data)
head(df)
str(df)

# 플롯 그리기
dv <- ggplot(df, aes(x=drv.data, y=hwy.data, fill=drv.data)) + 
  geom_violin()
dv + labs(title="202235-368052",
          x ="차량 구동방식", y = "고속도로 연비(mpg)") + 
  labs(fill = "차량 구동방식") +
  geom_boxplot(width=0.2) +
  scale_y_continuous(breaks=seq(0, 45, 5), limits=c(10, 45)) +
  scale_x_discrete(labels = c("4륜구동", "전륜구동", "후륜구동")) +
  theme(plot.title = element_text(hjust = 0.5))


help("mpg")
help("geom_violin")
help("hist")
help("pch")
help("data.frame")
help("matrix")
rm(list = ls())