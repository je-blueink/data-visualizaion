# ---- 3장 ggplot2----

# 패키지 준비
install.packages("ggplot2")
library(ggplot2)

# 데이터 준비
load("sah.RData")
head(sah)

## 3-3 산점도 그리기
ggplot(sah) + geom_point(aes(x=age, y=sbp)) # 가로축 나이, 세로축 수축기 혈압
ggplot(sah, aes(x=age, y=sbp)) + geom_point()
ggplot(sah, aes(age, sbp)) + geom_point()

## 3-4 산점도에 색상, 모양 채널 추가
ggplot(sah, aes(age, sbp, color=chd)) + geom_point() # 색상 추가
ggplot(sah, aes(age, sbp, shape=chd)) + geom_point() # 모양 추가

## 3-5 평활곡선 그래프
ggplot(sah, aes(age, sbp)) + geom_smooth()

## 3-6 평활곡선 그래프에 색상 추가
ggplot(sah, aes(age, sbp, color=chd)) + geom_smooth()

## 3-7 산점도에 평활곡선 겹쳐서
ggplot(sah, aes(age, sbp)) + geom_point() + geom_smooth()

## 3-8 객체에 그래프 저장하고 출력
a<-ggplot(sah, aes(age, sbp)) + geom_point()
a
a + geom_smooth() # 저장된 객체에 레이어 추가

## 3-9 가로축 범위 수정
ggplot(sah, aes(age, sbp)) + geom_point() + 
  scale_x_continuous(limits=c(0, 100)) # 가로축 범위를 0~100 으로 수정

## 3-10 줄바꿈 위치에 유의
ggplot(sah, aes(age, sbp)) + geom_point() 
+ scale_x_continuous(limits=c(0, 100)) # 더하기 앞에서 줄바꿈으로 오류 발생

## 3-11 x축, y축 범위 좁히기
a <- ggplot(sah, aes(age, sbp)) + geom_point() 
a + scale_x_continuous(limits=c(0, 100)) + scale_y_continuous(limits=c(90, 250))
a + lims(x=c(0, 100)) + lims(y=c(90, 250))
a + xlim(c(0, 100)) + ylim(c(90, 250)) # x축 범위 0~100, y축 범위 90~250

## 3-12 x축 범위 조정 시 평활곡선 변화 유의
a + geom_smooth()
a + geom_smooth() + xlim(c(20, 40))

## 3-13 기본 그래프에서 일부 범위만 출력
a + geom_smooth() + coord_cartesian(xlim=c(20, 40))

## 3-14 가로축 여분 조정
a + scale_x_continuous(limits=c(0, 100), expand = expansion(0)) 
a + scale_x_continuous(limits=c(0, 100), expand = expansion(add=10)) 
a + scale_x_continuous(limits=c(0, 100), expand = expansion(mult=0.3)) 

## 3-15 가로축 위치, 눈금 변경
a
a + scale_x_continuous(breaks=c(20, 40, 60))
a + scale_x_continuous(breaks=c(20, 40, 60), labels = c("20.0", "40.0", "60.0"))

# ---- 더 해보기 ----
### Program 3-16
ggplot(sah, aes(x=age, y=ldl))+geom_point()
ggplot(sah, aes(x=age, y=log(ldl)))+geom_point()
ggplot(sah, aes(x=age, y=ldl))+geom_point()+scale_y_continuous(trans="log")

### Program 3-17
b<-ggplot(sah, aes(x=BMI.cat, y=ldl))+geom_boxplot()
b

### Program 3-18
b + scale_x_discrete(limits=c("normal", "overweight", "obese"))
b + scale_x_discrete(limits=c("obese", "overweight"))
b + scale_x_discrete(limits=c("obese", "overweight", "unknown"))

### Program 3-19
b + scale_x_discrete(labels=c("UNDERWEIGHT", "NORMAL", "OVERWEIGHT", "OBESE"))
b + scale_x_discrete(labels=c(overweight="OVERWEIGHT", obese="OBESE"))

### Program 3-20
b + scale_x_discrete(breaks=c("obese", "overweight"))

### Program 3-21
b + scale_x_discrete(limits=c("normal", "overweight", "obese"), 
                     breaks=c("obese", "overweight"), 
                     labels=c(overweight="OVERWEIGHT", obese="OBESE"))

### Program 3-22
b + scale_x_discrete(guide = guide_axis(angle = 90))
b + guides(x = guide_axis(angle = 90))

### Program 3-23
ggplot(sah, aes(x=age, y=ldl, size=obesity)) + geom_point()

### Program 3-24
ggplot(sah, aes(x=age, y=ldl, size=obesity)) + geom_point() + scale_size(range = c(0.3, 3))

### Program 3-25
ggplot(sah, aes(x=age, y=ldl, shape=BMI.cat)) + geom_point()
ggplot(sah, aes(x=age, y=ldl, shape=BMI.cat)) + geom_point() + 
  scale_shape_manual(values=c("underweight"=1, "normal"=2, "overweight"=3, "obese"=4))

### Program 3-26
a
a+coord_flip()
b
b+coord_flip()

### Program 3-27
library(datarium)
ggplot(mice2, aes(before, after)) + geom_point() + coord_fixed()

### Program 3-28
a + facet_wrap(~chd)

### Program 3-29
a + facet_wrap(~BMI.cat)
a + facet_wrap(~BMI.cat, ncol=1)
a + facet_wrap(~BMI.cat, nrow=1)

### Program 3-30
a + facet_grid(.~famhist)
a + facet_grid(chd~.)
a + facet_grid(chd~famhist)

### Program 3-31
d<-ggplot(sah, aes(age, sbp, color=chd)) + geom_point()
d + labs(x="Age", y="SBP", title="Scatterplot", color="CHD")
d + xlab("Age") 
d + xlab("Age") + ylab("SBP") + ggtitle("Scatterplot")

### Program 3-32
d + labs(x="Age", y="SBP", title="Scatterplot", color="CHD") + 
  theme(plot.title = element_text(face="bold", color="red"))
d + labs(x="Age", y="SBP", title="Scatterplot", color="CHD") + 
  theme(plot.title = element_text(hjust=0.5))
d + labs(x="Age", y="SBP", title="Scatterplot", color="CHD") + 
  theme(plot.title = element_text(hjust=1))

### Program 3-33
d + labs(x="Age", y="SBP", title="Scatterplot", color="CHD") +
  theme(axis.title.x=element_text(face="italic", size=16),
        axis.title.y=element_blank(),
        legend.title=element_text(color = "blue"),
        legend.position="bottom",
        aspect.ratio=9/16
  )
### Program 3-34
d
ggsave("scatterplot.pdf")
ggsave("scatterplot2.jpg", width=5, height=4)

rm(list = ls())