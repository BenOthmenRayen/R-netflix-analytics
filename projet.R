
#library import
library(ggplot2)#for data visulation 
library(dplyr)#For data manipulation and transformation
library(corrplot)#For visualizing correlation matrices
library(GGally)#for multivariate analysis
library(tidyverse)#meta-package,for data science
library(ggpubr)

#loading the dataset
d <- read_csv("netflix_users.csv")

#displaying the dataset
view(d)

#dimensions du dataset
dim(d)
nrow(d)
ncol(d)

# Informations générales sur le dataset
str(d) 

# Statistiques descriptives
summary(d)

# Noms des colonnes
colnames(d)

# Types des colonnes
sapply(d, class)

#displaying the first 6 rows
head(d)

#displaying the last 6 rows
tail(d)

#Counting the occurrences of each subscription type
table(d$`subscription_type`)

#counting the occurrences of each gender 
table(d$gender)

#Plotting the distribution of subscribers by country
ggplot(d, aes(x = country)) +
  geom_bar() +
  theme_minimal()

#nombre dabonne par type dabonement 

ggplot(d, aes(x = `subscription_type`)) +
  geom_bar() +
  theme_minimal()

#hist de lage 

hist(d$age, main = "Distribution des ages", xlab = "Age")

ggplot(d, aes(x = age)) +
  geom_histogram(aes(y = ..density..), binwidth = 2, fill = "skyblue", color = "black") +
  geom_density(color = "red", size = 1) +
  theme_minimal()

boxplot(d$age, col = "orange", main = "Boxplot de l'âge")

ggplot(d, aes(x = `subscription_type`, y = age)) +
  geom_boxplot(fill = "lightgreen") +
  theme_minimal()

device_counts <- d %>%
  count(device)

ggplot(device_counts, aes(x = "", y = n, fill = device)) +
  geom_col(width = 1) +
  coord_polar("y") +
  ggtitle("distrubution des appareils") +
  theme_void()

ggplot(d, aes(x = subscribed_duration)) +
  geom_histogram(bins = 30, fill = "skyblue", color = "black") +
  ggtitle("distrubution de la durée d'abonnement") +
  xlab("subscribed_duration") +
  ylab("nombre d'utilisateur") +
  theme_minimal()

ggplot(d, aes(x = subscription_type, y = monthly_revenue)) +
  geom_boxplot() +
  xlab("Type d'abonnement") +
  ylab("Revenu Mensuel") +
  ggtitle("Revenu mensuel par type d'abonnement") +
  theme_minimal()

ggplot(d, aes(x = gender, y = monthly_revenue)) +
  geom_boxplot() +
  xlab("Genre") +
  ylab("Revenu mensuel") +
  ggtitle("Comparaison du revenu mensuel selon le genre") +
  theme_minimal()


gender_counts <- d %>%
  count(gender)

ggplot(gender_counts, aes(x = "", y = n, fill = gender)) +
  geom_col(width = 1) +
  coord_polar("y") +
  ggtitle("Répartition des abonnés par genre") +
  theme_void()

ggplot(d, aes(x = device, y = subscribed_duration)) +
  geom_boxplot() +
  xlab("Appareil utilisé") +
  ylab("Durée d'abonnement (mois)") +
  ggtitle("Comparaison de la durée selon le type d'appareil") +
  theme_minimal()

finding_outliers <- function(data, variable_name) {
  Q1 <- quantile(data[[variable_name]], 0.25, na.rm = TRUE)
  Q3 <- quantile(data[[variable_name]], 0.75, na.rm = TRUE)
  IQR <- Q3 - Q1
  lower <- Q1 - 1.5 * IQR
  upper <- Q3 + 1.5 * IQR
  outliers <- data[data[[variable_name]] < lower | data[[variable_name]] > upper, ]
  return(outliers)
}

# Exemples :
finding_outliers(d, "monthly_revenue")
finding_outliers(d, "clv")
finding_outliers(d, "subscribed_duration")


cor_matrix <- cor(d[sapply(d, is.numeric)], use = "complete.obs")

corrplot(cor_matrix, method = "color", type = "upper", tl.cex = 0.8, addCoef.col = "black", number.cex = 0.7)
title("Carte des Coefficients de corrélation")

ggplot(d, aes(x = monthly_revenue, y = clv)) +
  geom_point(color = "blue") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  xlab("Revenu Mensuel") +
  ylab("CLV") +
  ggtitle("Corrélation entre le revenu mensuel et la valeur à vie du client") +
  theme_minimal()

ggplot(d, aes(x = age, y = subscribed_duration)) +
  geom_point( alpha = 0.6) +
  xlab("Âge de l'utilisateur") +
  ylab("Durée d'abonnement (mois)") +
  ggtitle("Corrélation entre l'âge et la fidélité") +
  theme_minimal()

cor.test(d$monthly_revenue, d$subscribed_duration)

cor.test(d$age, d$clv)

cor.test(d$start_month, d$subscribed_duration)

cor.test(d$monthly_revenue, d$start_month)


cor.test(d$clv, d$subscribed_duration)

table1 <- table(d$subscription_type, d$device)
print(table1)

test1 <- chisq.test(table1)
print(test1)

table2 <- table(d$gender, d$subscription_type)
print(table2)

test2 <- chisq.test(table2)
print(test2)

table3 <- table(d$clv, d$subscribed_duration)
print(table3)

test3 <- chisq.test(table3)
print(test3)

filtered_data <- subset(d, 
                        country %in% c("United States", "Canada") & 
                          subscription_type %in% c("Basic", "Premium"))
table_fisher <- table(filtered_data$country, filtered_data$subscription_type)
print(table_fisher)
fisher_result <- fisher.test(table_fisher)
print(fisher_result)
