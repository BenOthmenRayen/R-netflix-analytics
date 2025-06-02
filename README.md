# R-netflix-analytics
## Netflix User Behavior Analysis with R
### Project Overview

As part of this project, we conducted an in-depth analysis of a dataset related to Netflix users.  
The primary objective was to better understand viewing habits, user preferences, and general usage trends on the platform.

### Technologies Used
- **Language**: R  
- **Key Libraries**:
- `ggplot2` for data visualization
- `dplyr` for data transformation
- `corrplot` for visualizing correlation matrices
- `GGally` for multivariate analysis
- `tidyverse` meta-package ,for data science
### to import libraries,we used the following command 
```
library(ggplot2)
library(dplyr)
library(corrplot)
library(GGally)
library(tidyverse)
```
### To load the dataset into R
```
d <-read_csv("netflix_users.csv")
```
### General Overview of the Dataset  
```
str(d)
```
<img src="screenshots/1.png" width="30%" />  
### Dataset Dimensions and Structure     
```   
dim(d)
```   
### Detailed Information on Dataset Columns        
```   
colnames(d)   
sapply(d,class)  
```   
### Sample Data Display and Inspection    
```   
head(d)    
tail(d)   
```
### Count of Occurrences for Each Subscription Type   
```
table(d$'subscription_type')   
```
### Count of Occurrences for Each Genre    
```
table(d$'gender')   
```
### Visual Representation of Subscriber Distribution by Country    
```   
ggplot(d, aes(x=country))+   
  geom_bar()+   
  theme_minimal()   
```
### User Count by Subscription Type   
```
ggplot(d, aes(x=subscription_type))+   
  geom_bar()+   
  theme_minimal()   
```
### Age Distribution Overview   
```  
hist(d$age , main="age distrubution",xlab="age")   
```   
### Age Distribution with Density Plot   
```  
ggplot(d, aes(x=age))+   
  geom_histogram(aes(y=..density..),binwidth=2,fill="skyblue", color="black")+     
  geom_density(color="red", size=1)+   
  theme_minimal()   
```   
### Boxplot Representation of Age Distribution  
```
ggplot(d, aes(y = age)) +
  geom_boxplot() +
  theme_minimal()
```
### Age Distribution by Subscription Type 
```
ggplot(d, aes(x = subscription_type, y = age)) +
  geom_boxplot() +
  theme_minimal()
```
### Device Distribution Represented by Pie Chart 
```
library(dplyr)
device_counts <- d %>% count(device_type)
ggplot(device_counts, aes(x = "", y = n, fill = device_type)) +
  geom_col(width = 1) +
  coord_polar(theta = "y") +
  theme_void() +
  labs(fill = "Device Type")
```
### Subscription Duration Distribution 
```
hist(d$subscription_duration, main = "Subscription Duration Distribution", xlab = "Duration (days)")
```
### Monthly Revenue Comparison by Gender 
```
ggplot(d, aes(x = gender, y = monthly_revenue)) +
  geom_boxplot() +
  theme_minimal()
```
### Comparison of Subscription Duration by Device Type   
```
ggplot(d, aes(x = device_type, y = subscription_duration)) +
  geom_boxplot() +
  theme_minimal()
```
### Graphical Representation of Subscriber Distribution by Country 
```
ggplot(d, aes(x = country)) +
  geom_bar() +
  theme_minimal()
```



