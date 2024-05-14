---
title: "STA130 Project Coding"
author: "Riyad Valiyev, Nicolas Dias Martins, Xuanqi Wei, Chloe Yang"
subtitle: Final Report
urlcolor: blue
output:
  pdf_document: default
---
# Research Question Coding

## Research Question 1

```{r setup, include=FALSE}
knitr::opts_chunk$set(eval=TRUE, include=TRUE, echo=TRUE, message=TRUE, warning=FALSE)
```


```{r, message=FALSE}
#First, load the libraries (tidyverse, arrow and patchwork). In addition to that, install the arrow package if you haven't yet.
# install.packages("arrow")
library(tidyverse)
library(arrow)
library (patchwork)
```

```{r}
#Read the second parquet and get a glimpse of it.
galaxy_part2 <- read_parquet("nsa_v1_0_1_key_cols.parquet")
glimpse(galaxy_part2)
```
```{r}
#Clean the data.
galaxy_part2 <- galaxy_part2 %>% na.omit()
```

```{r}
#Let's find the outliers for each variable and visualize each one of them.
galaxy_part2 %>% ggplot(aes(x= petro_th50)) + geom_boxplot(fill = 'lightblue') + ggtitle("petro_th50's boxplot")
galaxy_part2 %>%  ggplot(aes(x = petro_theta)) + geom_boxplot(fill = 'orange', alpha = 0.5) + ggtitle("petro_theta's boxplot")
galaxy_part2 %>%  ggplot(aes(x = petro_th90)) + geom_boxplot(fill = 'lightgreen', alpha = 0.7) + ggtitle("petro_th90's boxplot")

```

```{r}
#Let's remove some outliers now!
outliers <- function(x) {

  Q1 <- quantile(x, probs=.25)
  Q3 <- quantile(x, probs=.75)
  iqr = Q3-Q1

 upper_limit = Q3 + (iqr*1.5)
 lower_limit = Q1 - (iqr*1.5)

 x > upper_limit | x < lower_limit
}

remove_outliers <- function(galaxy_part2, cols = names(galaxy_part2)) {
  for (col in cols) {
    galaxy_part2 <- galaxy_part2[!outliers(galaxy_part2[[col]]),]
  }
  galaxy_part2
}

galaxy_part2 <- remove_outliers(galaxy_part2, c('petro_th50', 'petro_th90', 'petro_theta'))
```

```{r, , fig.width=8}
#Now, let's take a look at the boxplots again. Way better now!
b_petro_th50 <- galaxy_part2 %>% ggplot(aes(x= petro_th50)) + geom_boxplot(fill = 'lightblue') +  coord_cartesian(xlim = c(0, 15)) + ggtitle("petro_th50's boxplot")
b_petro_theta <- galaxy_part2 %>%  ggplot(aes(x = petro_theta)) + geom_boxplot(fill = 'orange', alpha = 0.5) + coord_cartesian(xlim = c(0, 15)) + ggtitle("petro_theta's boxplot")
b_petro_th90 <- galaxy_part2 %>%  ggplot(aes(x = petro_th90)) + geom_boxplot(fill = 'lightgreen', alpha = 0.7) + coord_cartesian(xlim = c(0, 15)) + ggtitle("petro_th90's boxplot")
b_petro_th50 + b_petro_theta + b_petro_th90
```

```{r, fig.width=8}
#Create histograms for each variable ('petro-th50', 'petro_theta', and 'petro_th90') and visualize all of them in a single plot.
h_petro_th50 <- galaxy_part2 %>%  ggplot(aes(x = petro_th50)) + geom_histogram(bins = 100, fill = 'lightblue') + coord_cartesian(xlim = c(0, 15), ylim = c(0, 17500)) + ggtitle("petro_th50's histogram")

h_petro_theta <- galaxy_part2 %>%  ggplot(aes(x = petro_theta)) + geom_histogram(bins = 100, fill = 'orange', alpha = 0.5) + coord_cartesian(xlim = c(0, 15), ylim = c(0, 17500)) + ggtitle("petro_theta's histogram")

h_petro_th90 <- galaxy_part2 %>%  ggplot(aes(x = petro_th90)) + geom_histogram(bins = 100, fill = 'lightgreen', alpha = 0.7) + coord_cartesian(xlim = c(0, 15), ylim = c(0, 17500)) + ggtitle("petro_th90's histogram")

h_petro_th50
h_petro_theta
h_petro_th90
h_petro_th50 + h_petro_theta + h_petro_th90

ggplot() + geom_histogram(aes(x=galaxy_part2$petro_th50), bins = 100, fill = 'lightblue') + geom_histogram(aes(x=galaxy_part2$petro_theta), bins = 100, fill = 'orange', alpha = 0.5) + geom_histogram(aes(x=galaxy_part2$petro_th90), bins = 100, fill = 'lightgreen', alpha = 0.7) + ggtitle("petro histograms")  
```

```{r}
#Summarize the means, medians, minimums, maximums, and standard deviation of the variables.
summarize(galaxy_part2, mean_petro_th50 = mean(petro_th50), mean_petro_theta = mean(petro_theta), mean_petro_th90 = mean(petro_th90))
summarize(galaxy_part2, median_petro_th50 = median(petro_th50), median_petro_theta = median(petro_theta), median_petro_th90 = median(petro_th90))
summarize(galaxy_part2, min_petro_th50 = min(petro_th50), min_petro_theta = min(petro_theta), min_petro_th90 = min(petro_th90))
summarize(galaxy_part2, max_petro_th50 = max(petro_th50), max_petro_theta = max(petro_theta), max_petro_th90 = max(petro_th90))
summarize(galaxy_part2, sd_petro_th50 = sd(petro_th50), sd_petro_theta = sd(petro_theta), sd_petro_th90 = sd(petro_th90))
```

```{r, fig.width=8}
#Let's start bootstrapping! We are getting a 1000 simulations of the entire sample for each variable ('petro-th50', 'petro_theta', and 'petro_th90').

set.seed(666)

N <- 1000
n <- 559320

simulated_petro_th50 <- 1:N
for(i in 1:N){
  simulated_x1 <- mean(sample(galaxy_part2$petro_th50, size=n, replace=TRUE))
  simulated_petro_th50[i] <- simulated_x1
}
boot_th50 <- ggplot() + geom_histogram(bins = 50, colour = 'grey', fill = 'lightblue') + aes(x=simulated_petro_th50) + ggtitle("petro_th50 boot histogram")

quantile(simulated_petro_th50, c(0.05, 0.95))

simulated_petro_theta <- 1:N
for(i in 1:N){
  simulated_x2 <- mean(sample(galaxy_part2$petro_theta, size=n, replace=TRUE))
  simulated_petro_theta[i] <- simulated_x2
}
boot_theta <- ggplot() + geom_histogram(bins = 50, colour = 'grey', fill = 'orange', alpha = 0.5) + aes(x=simulated_petro_theta)+ ggtitle("petro_theta boot histogram")

quantile(simulated_petro_theta, c(0.05, 0.95))

simulated_petro_th90 <- 1:N
for(i in 1:N){
  simulated_x3 <- mean(sample(galaxy_part2$petro_th90, size=n, replace=TRUE))
  simulated_petro_th90[i] <- simulated_x3
}

boot_th90 <- ggplot() + geom_histogram(bins = 50, colour = 'grey', fill = 'lightgreen', alpha = 0.7) + aes(x=simulated_petro_th90) + ggtitle("petro_th90 boot histogram")

quantile(simulated_petro_th90, c(0.05, 0.95))

boot_th50
boot_theta
boot_th90

boot_th50 + boot_theta + boot_th90
```


## Research Question 2 Coding & Writing
```{r, include=FALSE}
knitr::opts_chunk$set(eval=TRUE, include=TRUE, echo=FALSE, message=TRUE, warning=FALSE)
```

```{r, message=FALSE}
# install.packages("arrow")
library(tidyverse)
library(arrow)
```

```{r}
df <- read_parquet("nsa_v1_0_1_key_cols.parquet") %>% na.omit()
```

**Introduction:**

The driving motivation for the statistical analysis outlined below is our aspiration to find out some of the mysteries of our universe by exploring the relationships among the celestial objects that roam in it. The question that we have put forward to base our research on in this section is the following: "Do the galaxies farthest to the Earth differ significantly from the closest ones in terms of their total luminosity?". In the hopes of discovering a definitive answer to this question, we will analyse the relationship between two of the attributes of our observed galaxies: their "total luminosity/intrinsic brightness" and their "redshift values" which could be expressed in a less technical way as "how far the given galaxy is located from the planet Earth". It is recommended that, before diving into our analysis, our readers familiarize themselves with the notion of hypothesis test, and in particular p-value, test statistic, null/alternative hypotheses, mean, sampling, shuffling and similar statistical terms so as to understand our results to the fullest.

**Data:**

The data that we have utilized and will be accounting for throughout our report, Galaxy Zoo Tabular Data Contents, is taken from NASA-Sloan Atlas (nsa\_v1\_0\_1\_key\_cols.parquet) which was provided by Mike Walmsley. The data set includes a broad range of information regarding 641,409 distinct galaxies such as their stellar mass, star formation rates, shapes, et cetera. Amongst ten columns this data set contains, our focus will be on redshift and elpetro_absmag\_r throughout this analysis, the latter one standing for the galaxy's total intrinsic brightness. The first thing we did upon downloading the data was to omit the values that are missing from the table, i.e. NA values, so that we would only take into account the observations with complete information in respective columns. Making sure that we carry out this data cleaning process before moving on to the integral parts of our analysis- implementing the methods, is very important in terms of ensuring the accuracy and minimal twistedness in our findings. Additionally, in one of the stages of our analysis that is specified below, we temporarily removed the mean elpetro\_absmag\_r values that lay outside of the interquartile range, being lower than 25th and higher than 75th percentiles, for the purposes of refining one of our visualization and delivering a clearer picture of the plot. Finally, one of the most critical steps we have taken in the entire research process was extracting two smaller subsets of the full data set: 1000 observations with the highest redshift values (corresponding to the galaxies in the data set that are farthest from the Earth) and 1000 observations with the lowest redshift values (corresponding to the galaxies in the data set that are closest to the Earth). We have saved these groups of observations in two distinct data frames and passed in just three variables for each: redshift, total intrinsic brightness', and a column indicating whether they belong to the farthest or closest' category of galaxies.

```{r}
furthest_1000 <- df %>% arrange(desc(redshift)) %>% select(elpetro_absmag_r, redshift) %>% head(n=1000) %>% mutate(distance='furthest')

data.frame(furthest_1000) %>% glimpse()
```

```{r}
closest_1000 <- df %>% arrange(redshift) %>% select(elpetro_absmag_r, redshift) %>% head(n=1000) %>% mutate(distance='closest')

data.frame(closest_1000) %>% glimpse()
```

**Methods/Analysis:**

On the way to addressing our main research question, we will making use of hypothesis test. In the first place, we will compute the absolute difference of the mean total luminosity values of these two groups (the furthest 1000 galaxies and closest 1000 ones). The result we'll get from this computation will give us some intuition towards the ultimate answer we seek. However, unless properly tested and verified, we can never be entirely sure if this result is just a product of some randomness that originates from the limitedness of our samples or is actually a significant finding. An at that point, hypothesis test will help us establish whether the difference (if any) indeed implies a general rule for the whole population of galaxies in the universe, or we cannot conclude such a general rule of "distance affecting brightness" simply because it could be a coincidence. The test will be ran under the null assumption that the aforementioned difference is zero, or put in another way, the mean luminosities of the groups are equal to each other. Our test will consist of 10,000 simulations where each simulation will involve shuffling 2,000 observations with "furthest" and "closest" attribute and assign them randomly to either category. Later, we will compute the p-value based on the percentage of the cases where we obtain at least as extreme difference as what we have measured, between the randomly shuffled groups.

**Results:**

As the first step, we have analyzed the distribution of data in both groups through a number of numerical measures such as their minimum, maximum, mean, median values and standard deviation. Even though we are mainly interested in mean values of our sub-data sets, we took a quick look at median, range and standard deviation to have a rough understanding of what the shapes and skewness of our distributions look like and how much our mean values are impacted by the so-called "outlier bias". In particular, we intended to compare the median and mean values of each group to see how remote they are from each other (with the hopes that they would not be too much distanced). And in fact, our results at the first stage turned out to be quite promising for both categories:

```{r}
furthest_1000 %>% summarise(
            min = min(elpetro_absmag_r),
            max = max(elpetro_absmag_r),
            mean = mean(elpetro_absmag_r),
            median = median(elpetro_absmag_r),
            sd = sd(elpetro_absmag_r))
```

```{r}
closest_1000 %>% summarise(
            min = min(elpetro_absmag_r),
            max = max(elpetro_absmag_r),
            mean = mean(elpetro_absmag_r),
            median = median(elpetro_absmag_r),
            sd = sd(elpetro_absmag_r))
```
Later, we have plotted the mean values of these groups using a bar graph. In doing so, we wanted to visualize the comparison between the mean total brightness of "furthest" and "closest" galaxies, and make it more explicit through an illustration. While the mean total brightness of "closest" galaxies stood at around -12, that of the "furthest" ones was as low as around -21 absolute magnitudes. 

```{r}
# Create a dataframe with the mean values
combined <- data.frame(mean_value = c(mean(closest_1000$elpetro_absmag_r), mean(furthest_1000$elpetro_absmag_r)),
                 group = c("Closest 1000", "Furthest 1000"))

# Create the bar graph
ggplot(combined, aes(x = group, y = mean_value, fill = group)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "Group", y = "Mean Value of elpetro_absmag_r", title = "Comparison of Mean Values") +
  theme_minimal()
```

As we can see, the result is pretty noticeable. But we need to see if this is a part of some downward trend in the whole data set, suggesting a negative correlation between total brightness and redshift values, or just a random occurrence where the closest and furthest galaxies happened to have difference of 9 absolute magnitudes in terms of their mean total luminosities. To measure it, we grouped each 1000 rows of the data frame where ‘redshift’ is in an increasing order and got over 641 groups out of 641,166 observations. Next, we illustrated the line graph of the mean ‘elpetro absmag r’ values corresponding to each 1000-row group. The resulting line graph would need to have its x-axis correspond to each group of 1000 galaxies that are ordered as per their red-shift values (from least to most) and y-axis attributing to mean ‘elpetro absmag r’ of each group. One problem that we encountered while plotting this result was the outliers / unusually distant y-values. Given the sensitivity of line graphs to outliers, the extreme mean ‘elpetro absmag r’ values were distorting the shape of the graph, disfiguring the general trend and making it harder for the reader to follow the line. To tackle it, we removed the mean values that lay outside of the interquartile range (in other words, those higher than 75th percentile and lower than 25th percentile). Upon doing that, we got a more good-looking plot demonstrating an obvious downward tendency between the variables, and confirming our expectations:

```{r}
df <- arrange(df, redshift)

# group each 1000 rows of redshift values together and calculate the mean of elpetro_absmag_r
df_summary <- df %>%
  mutate(group = ceiling(row_number() / 1000)) %>%
  group_by(group) %>%
  summarize(mean_elpetro_absmag_r = mean(elpetro_absmag_r))

# calculate the IQR of the mean_elpetro_absmag_r variable
q1 <- quantile(df_summary$mean_elpetro_absmag_r, 0.25)
q3 <- quantile(df_summary$mean_elpetro_absmag_r, 0.75)
iqr <- q3 - q1

# define outliers as any value more than 1.5 times the IQR above the 75th percentile or below the 25th percentile
upper <- q3 + 1.5 * iqr
lower <- q1 - 1.5 * iqr
outliers <- df_summary$mean_elpetro_absmag_r > upper | df_summary$mean_elpetro_absmag_r < lower

# remove outliers from the dataset
df_summary_no_outliers <- df_summary[!outliers,]

# plot the results without outliers
ggplot(df_summary_no_outliers, aes(x = group, y = mean_elpetro_absmag_r)) +
  geom_line(aes(color = group)) +
  theme_light() +
  labs(x = "1000-row groups of redshift values (in an ascending order)", y = "Mean elpetro_absmag_r") 

```
Next up, we have combined our two sub-data sets into a large one consisting of 2000 rows: 1000 from closest galaxies and 1000 from furthest ones. We have previously determined that the our test statistic (the actual difference between the mean total brightness of these groups) was around 9 absolute magnitudes. However, to make our calculations more precise, we calculated the test statistic anew using R computations and obtained the following:

```{r}
combined_df <- rbind(closest_1000, furthest_1000)

distance_vector <- c(rep("furthest", 1000), rep("closest", 1000))
```

```{r}
# Note: including the .groups="drop" option in summarise() will suppress 
# a friendly warning that R normally prints out:
# "`summarise()` ungrouping output (override with `.groups` argument)".  
test_stat <- combined_df %>% group_by(distance) %>%
  summarise(means = mean(elpetro_absmag_r), .groups="drop") %>%
  summarise(value = diff(means))

test_stat <- test_stat %>% as.numeric() %>% abs()

test_stat
```

Now that we have all of our tools at hand, we can run our 10,000 simulations and observe the results. As a reminder, our null hypothesis was that "there is no difference between the mean total luminosity of the farthest and closest galaxies" while the alternative hypothesis was stating exactly the opposite: "there is a difference between the mean total luminosity of the farthest and closest galaxies". Through the methods we have explained in the analysis section above, we will first plot the distribution of the 10,000 simulated values (that is, the difference between the mean total brightness of randomly shuffled groups) under the assumption that the null hypothesis is true:

```{r}
student_num = 1009069874 # list your student number
student_num_last2 = 74 # list the last two digits of your student number
set.seed(student_num_last2) # REQUIRED so the result is reproducible!

repetitions <- 10000  # feel free to increase this is you want finer precision
simulated_values <- rep(NA, repetitions)

for(i in 1:repetitions){
  # perform a random permutation and compute the simulated test statistic
  # randomly shuffle
simdata <- combined_df %>% 
  mutate(distance = sample(distance_vector, replace=FALSE))

# re-compute the test statistic
sim_value <- simdata %>% group_by(distance) %>%
  summarise(means = mean(elpetro_absmag_r), .groups="drop") %>%
  summarise(value = diff(means))
  
  
  # store the simulated value
  simulated_values[i] <- as.numeric(sim_value)
}

# convert vector results to a tibble
sim <- tibble(mean_diff = simulated_values)

# plot the results
tibble(simulated_values) %>% ggplot() + 
  geom_histogram(fill="skyblue", colour="darkgray", bins=100) +
  aes(x=simulated_values)
```
The results are pretty significant: we see a very large portion of the values gathered in an interval centered at 0.0. Which is even more significant, however, is the fact that the range of this interval is just around -1.0 and 1.0 (roughly). This preliminary observation, along with a quick glance at the histogram of this distribution, imply that there is almost no chance that a measurable amount of data would lie outside of the interval from -9.2 to 9.2. That being said, we made our final move and statistically approved our observations via numbers by computing the p-value. And we got the following:

```{r}
# compute the p-value
  # If you are performing a 2-sided test we only care about the
  # *absolute difference* between the two samples, not whether the difference
  # is bigger or smaller
  p_2side = sum(abs(simulated_values) >= abs(test_stat)) / repetitions
  p_2side
```

In 0% of the cases, the difference between the simulated groups was more than or equal to |9.2|, which is equivalent to saying the following statement: The probability that our measured difference of 9.2 could be due to randomness is 0!

**Discussions:**

The fact that our computed p-value is 0 suggests that we don't even need a certain alpha level to be able to reject the null hypothesis. As our p-value falls under any possible alpha level > 0 and successfully proves itself as being statistically significant in all cases, we can wholeheartedly assert that the idea that the furthest and closest galaxies might in fact have the same total luminosity should be rejected. Thanks to the hypothesis test, we discovered a correlation between two independent attributes of galaxies in the universe; what's more, our test helped us present this finding in such a way that an otherwise relationship could not be argued. 

On top of it, we have also strengthened our findings by plotting the tendency between our variables that encompassed the entire data set. If our line graph visualizing the relationship of "elpetro_absmag_r" to increasing "redshift" values had had a "zigzag" pattern, there would have been a very good chance that our measured difference is due to randomness and does not account for any significant relationship. This would have also reflected itself in the p-value, as we would have most probably obtained a value way above 0. However, the fact that our line graph had a crystal-clear negative tendency all along the 641 groups of observations, was almost an announcement of the final results in advance of the time and something that filled us with a number of justifiable expectations.

We have also showcased that the hypothesis test is an immensely powerful tool to utilize when we're in doubt of our results and pondering the question of "what if our findings just happened to turn out like this?". Regardless of the magnitude of the measured results and how "significant" they appear to be, there is always a potential bias coming from the limitedness of the sample being worked on. Nonetheless, if one wants to generalize their findings achieved from "just a sample" to "the whole population", the hypothesis test is always a way to go!

**Conclusion:**

To summarize, with an initial aim of discovering a relationship between the distances and total intrinsic brightness of the galaxies in the universe, we have firstly showed that there is a 9-unit difference between the mean total brightness of the furthest 1,000 and closest 1,000 galaxies with respect to the planet Earth in the data set. Using hypothesis test, we have revealed that this difference could not be achieved out of coincidence (if they were equal to each other) and acquired a 0 p-value in the process, proving that our measured findings were statistically significant. We have reinforced our point by constructing a line-graph that showcased an obvious downward trend between the variables that we were investigating.

## Research Question 3

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
library(tidyverse)
library(arrow)
setwd("C:/Users/Chloe/Desktop/galaxy_zoo")
df2 <- read_parquet("C:/Users/Chloe/Desktop/galaxy_zoo/nsa_v1_0_1_key_cols.parquet")
df2 <- df2 %>% filter(!is.na(elpetro_absmag_r))%>%filter(!is.infinite(elpetro_absmag_r))
df2 <- df2 %>% filter(!is.na(redshift))%>%filter(!is.infinite(redshift))
```

```{r cars}
glimpse(df2)
```

## Including Plots
```{r,warning=FALSE}
df2 %>% ggplot(aes(x=redshift)) + geom_histogram(fill = "grey", colour = "black") 
df2 %>% ggplot(aes(x=elpetro_absmag_r)) + geom_histogram(fill = "grey", colour = "black") 
```
For histogram:

the histogram of redshift is unimodal approximately symmetric with a slight tendency towards the right side. The majority of the stars form this data set is between 0.07-0.075, which is in the midddle of the range.
the histogram of brightness is unimodal approximately symmetric with a slight tendency towards the left side. The majority of the stars form this data set is between -18.75 to -20, which is in the middle of the range.
Both histogram have similar shape, it seems like they might have some relationship, but only analysis histogram can not tell that, we need to use linear regression model to see if the brightness and distance have a certain correlation.

You can also embed plots, for example:

```{r,warning=FALSE}
df2 %>% ggplot(aes(redshift, elpetro_absmag_r)) + geom_point()+ geom_smooth(se=FALSE, method="lm") + theme_minimal()
```
```{r,warning=FALSE}
mod <- lm(elpetro_absmag_r ~ redshift, data = df2)
summary(mod)$coefficients

```
Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.

