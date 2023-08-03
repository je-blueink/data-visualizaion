getwd()
install.packages("sf")
install.packages("geodata")
install.packages("reshape2")
install.packages("xts")
install.packages("maps")
install.packages("scico")

library(maps)
library(scico)

# 미세먼지 수치 시각화
library(readxl)
library(dplyr)
library(reshape2)
library(xts)
library(ggplot2)

# 데이터 가져오기
pm_data = read_excel("./data/pm_data.xlsx")
head(pm_data)
pm3 = melt(pm_data, id="date")
head(pm3)

# 선그래프 그리기
pm3 %>% ggplot(aes(x=date)) + facet_grid(variable~.) +
  geom_line(aes(y=value, color=variable)) + 
  labs(x="", y="", color="도시", title="미세먼지 수치") +
  theme_bw()

# 국경선 시각화
library(ggplot2)
library(dplyr)
library(sf)
library(geodata)

# world 함수 사용
border_data = world(resolution = 5, level = 0, path =  "./data")
border_sf = st_as_sf(border_data)
names(border_sf)
border_sf$NAME_0

# 필요한 부분 선택
border_sf1 = border_sf %>% 
  filter(NAME_0=="China" | NAME_0=="South Korea"| 
           NAME_0=="Japan" |NAME_0=="North Korea")

# 지도 그리기
m = ggplot(data = border_sf1) + 
  geom_sf(aes(color=NAME_0)) +
  geom_sf_label(aes(label=NAME_0)) +
  coord_sf() + theme_bw()
m + labs(x="", y="",  color="국가", title="한중일 국경선")

# ---- 도구 ----
# Get the map data for the countries
world_map <- map_data("world")
countries <- c("South Korea", "North Korea", "Japan", "China")
map_data <- world_map[world_map$region %in% countries,]

# Plot the map
ggplot() +
  geom_polygon(data = map_data, aes(x = long, y = lat, group = group), 
               fill = "white", color = "black") +
  coord_fixed(1.3) +
  theme_void()

# 데이터 받기
gadm_kor = gadm(country = 'KOR', level = 0, path = "./data")
gadm_prk = gadm(country = 'PRK', level = 0, path = "./data")
gadm_jpn = gadm(country = 'JPN', level = 0, path = "./data")
gadm_chn = gadm(country = 'CHN', level = 0, path = "./data")
gadm_border = rbind(gadm_kor, gadm_chn, gadm_jpn, gadm_prk)

# sf 객체로 변환
gadm_border_sf = st_as_sf(gadm_border)

# 지도 그리기
ggplot() + geom_sf(data = gadm_border_sf) + 
  labs(title="국경선") +
  geom_sf_label(aes(label=COUNTRY))


help("scico")
scico_palette_show()
gadm_border_sf$COUNTRY
gadm_jpn_sf$COUNTRY
names(gadm_border)
help("st_as_sf")
help("world")

rm(list = ls())