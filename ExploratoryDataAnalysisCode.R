library(tidyverse)
library(GGally)
library(knitr)
library(tsne)

options(warn=-1)

aave <- read_csv("data/AaveWalletSegmentationDataWithClusters.csv")
dem_vars <- c("agedays", "num_chains_active", "num_tokens", "aave_amt",
              "bal_usd", "eth_bal_usd_", "aave_asset_usd", "aave_debt_usd",
              "aave_net_usd", "lens_prof_count", "lens_id",
              "lens_name", "lens_followers", "lens_following",
              "lens_posts", "lens_comments", "lens_mirrors", "lens_publications",
              "lens_collects", "snap_voted_aave_numprop",
              "trustalabs_score")

aave <- aave %>%
  mutate(`User Type` = ifelse(!iscontract & !ismultisig, "Single Wallets", 
                              ifelse(iscontract & !ismultisig, "Contracts", 
                                     ifelse(ismultisig, "Multi-Signature Safes", "Other"))))


###
# Part One: Histograms
###

# C Histograms
p11 <- aave %>%
  select(starts_with("C_")) %>%
  gather(key = Chain, value = Value) %>%
  ggplot(aes(x = Value, fill = Chain)) +
  geom_histogram(colour = "black") +
  facet_wrap(~Chain, ncol = 1, scales = "free_y") +
  scale_fill_brewer(palette = "Dark2") +
  scale_x_log10(labels = scales::comma, breaks = 10^(0:6)) +
  scale_y_continuous(labels = scales::comma) +
  theme(legend.position = "off") +
  labs(
    title = "Distribution of Number of Calls by Chain",
    subtitle = "For AAVE",
    x = "Number of Calls",
    y = "Number of Wallet Addresses"
  )

p11

ggsave(p11, filename = "images/p11.png", dpi = 300, width = 12, height = 12)

aave %>%
  select(starts_with("C_")) %>%
  gather(key = Chain, value = Value) %>%
  summary(Value)


# E Histograms
p12 <- aave %>%
  select(starts_with("E_")) %>%
  gather(key = Chain, value = Value) %>%
  ggplot(aes(x = Value, fill = Chain)) +
  geom_histogram(colour = "black") +
  facet_wrap(~Chain, ncol = 1, scales = "free_y") +
  scale_fill_brewer(palette = "Set1") +
  scale_x_log10(labels = scales::comma, breaks = 10^(0:6)) +
  scale_y_continuous(labels = scales::comma) +
  theme(legend.position = "off") +
  labs(
    title = "Distribution of Number of Call Types",
    subtitle = "For AAVE",
    x = "Number of Calls",
    y = "Number of Wallet Addresses"
  )

p12

ggsave(p12, filename = "images/p12.png", dpi = 300, width = 12, height = 12)

aave %>%
  select(starts_with("E_")) %>%
  gather(key = Chain, value = Value) %>%
  summary(Value)


# E Histograms
p13 <- aave %>%
  select(starts_with("V_")) %>%
  gather(key = Chain, value = Value) %>%
  ggplot(aes(x = Value, fill = Chain)) +
  geom_histogram(colour = "black") +
  facet_wrap(~Chain, ncol = 1, scales = "free_y") +
  scale_fill_brewer(palette = "Set2") +
  scale_x_log10(labels = scales::comma, breaks = 10^(0:6)) +
  scale_y_continuous(labels = scales::comma) +
  theme(legend.position = "off") +
  labs(
    title = "Distribution of Number of Version Calls",
    subtitle = "For AAVE",
    x = "Number of Calls",
    y = "Number of Wallet Addresses"
  )

p13

ggsave(p13, filename = "images/p13.png", dpi = 300, width = 12, height = 12)

aave %>%
  select(starts_with("V_")) %>%
  gather(key = Chain, value = Value) %>%
  summary(Value)


###
# Part Two: User Type
###

# C Histograms
p21 <- aave %>%
  select(`User Type`, starts_with("C_")) %>%
  gather(key = Chain, value = Value, 2:ncol(.)) %>%
  filter(!is.na(`User Type`)) %>%
  ggplot(aes(x = Value, fill = Chain)) +
  geom_histogram(colour = "black") +
  facet_grid(Chain~`User Type`, scales = "free_y") +
  scale_fill_brewer(palette = "Dark2") +
  scale_x_log10(labels = scales::comma, breaks = 10^(0:6)) +
  scale_y_continuous(labels = scales::comma) +
  theme(legend.position = "off") +
  labs(
    title = "Distribution of Number of Calls by Chain",
    subtitle = "For AAVE, Split by User Type",
    x = "Number of Calls",
    y = "Number of Wallet Addresses"
  )

p21

ggsave(p21, filename = "images/p21.png", dpi = 300, width = 12, height = 12)

aave %>%
  select(`User Type`, starts_with("C_")) %>%
  gather(key = Chain, value = Value, 2:ncol(.)) %>%
  filter(!is.na(`User Type`)) %>%
  summary(Value)


# E Histograms
p22 <- aave %>%
  select(`User Type`, starts_with("E_")) %>%
  gather(key = Chain, value = Value, 2:ncol(.)) %>%
  filter(!is.na(`User Type`)) %>%
  ggplot(aes(x = Value, fill = Chain)) +
  geom_histogram(colour = "black") +
  facet_grid(Chain~`User Type`, scales = "free_y") +
  scale_fill_brewer(palette = "Set1") +
  scale_x_log10(labels = scales::comma, breaks = 10^(0:6)) +
  scale_y_continuous(labels = scales::comma) +
  theme(legend.position = "off") +
  labs(
    title = "Distribution of Number of Call Types",
    subtitle = "For AAVE, Split by User Type",
    x = "Number of Calls",
    y = "Number of Wallet Addresses"
  )

p22

ggsave(p22, filename = "images/p22.png", dpi = 300, width = 12, height = 12)

aave %>%
  select(`User Type`, starts_with("E_")) %>%
  gather(key = Chain, value = Value, 2:ncol(.)) %>%
  filter(!is.na(`User Type`)) %>%
  summary(Value)


# V Histograms
p23 <- aave %>%
  select(`User Type`, starts_with("V_")) %>%
  gather(key = Chain, value = Value, 2:ncol(.)) %>%
  filter(!is.na(`User Type`)) %>%
  ggplot(aes(x = Value, fill = Chain)) +
  geom_histogram(colour = "black") +
  facet_grid(Chain~`User Type`, scales = "free_y") +
  scale_fill_brewer(palette = "Set2") +
  scale_x_log10(labels = scales::comma, breaks = 10^(0:6)) +
  scale_y_continuous(labels = scales::comma) +
  theme(legend.position = "off") +
  labs(
    title = "Distribution of Number of Version Calls",
    subtitle = "For AAVE, Split by User Type",
    x = "Number of Calls",
    y = "Number of Wallet Addresses"
  )

ggsave(p23, filename = "images/p23.png", dpi = 300, width = 12, height = 12)


# Table
aave %>%
  select(`User Type`, starts_with("C_"), starts_with("E_"), starts_with("V_")) %>%
  gather(key = Variable, value = Value, 2:ncol(.)) %>%
  group_by(`User Type`, Variable) %>%
  summarise(`Mean Count` = mean(Value, na.rm = TRUE),
            `Median Count` = median(Value, na.rm = TRUE),
            `SD Count` = sd(Value, na.rm = TRUE)) %>%
  filter(!is.na(`User Type`)) %>%
  kable()


###
# Part Three: Analysis
###

# CE Histograms
p31 <- aave %>%
  filter(`User Type` == "Single Wallets") %>%
  select(starts_with("CE_ethereum_"), one_of(dem_vars)) %>%
  mutate(across(everything(), as.numeric)) %>%
  gather(key = Variable, value = Value) %>%
  mutate(Group = ifelse(str_starts(Variable, "CE_ethereum_"), "blue", "gold")) %>%
  ggplot(aes(x = Value, fill = Group)) +
  geom_histogram(colour = "black") +
  facet_wrap(~Variable, scales = "free") +
  scale_fill_manual(values = c("blue", "gold")) +
  scale_x_continuous(trans=scales::pseudo_log_trans(base = 10)) +
  scale_y_continuous(labels = scales::comma) +
  theme(legend.position = "off") +
  labs(
    title = "Distribution Plots of the Feature Set",
    subtitle = "For AAVE, for Single Wallets with Debank Data",
    x = "Amounts, Values or Scores",
    y = "Number of Wallet Addresses"
  )

p31

ggsave(p31, filename = "images/p31.png", dpi = 300, width = 12, height = 12)

aave %>%
  filter(`User Type` == "Single Wallets") %>%
  select(starts_with("CE_ethereum_"), one_of(dem_vars)) %>%
  mutate(across(everything(), as.numeric)) %>%
  gather(key = Variable, value = Value) %>%
  summary(Value)


p32 <- aave %>%
  filter(`User Type` == "Single Wallets") %>%
  select(starts_with("CE_ethereum_"), one_of(dem_vars)) %>%
  mutate(across(everything(), as.numeric)) %>%
  ggpairs(cardinality_threshold = 50)

ggsave(p32, filename = "images/p32.png", dpi = 300, width = 30, height = 30)


###
# Part Four: Debank Only
###
aave_final <- aave %>%
  filter(if_debank_data, `User Type` == "Single Wallets") 

p41 <- aave_final %>%
  select(starts_with("CE_ethereum_"), one_of(dem_vars)) %>%
  mutate(across(everything(), as.numeric)) %>%
  gather(key = Variable, value = Value) %>%
  mutate(Group = ifelse(str_starts(Variable, "CE_ethereum_"), "blue", "gold")) %>%
  ggplot(aes(x = Value, fill = Group)) +
  geom_histogram(colour = "black") +
  facet_wrap(~Variable, scales = "free") +
  scale_fill_manual(values = c("blue", "gold")) +
  scale_x_continuous(trans=scales::pseudo_log_trans(base = 10)) +
  scale_y_continuous("Count", labels = scales::comma) +
  theme(legend.position = "off") +
  labs(
    title = "Distribution of Various Variables",
    subtitle = "For AAVE, for Single Wallets with Debank Data"
  )

ggsave(p41, filename = "images/p41.png", dpi = 300, width = 12, height = 12)


p42 <- aave_final %>%
  select(starts_with("CE_ethereum_"), one_of(dem_vars)) %>%
  mutate(across(everything(), as.numeric)) %>%
  ggpairs(cardinality_threshold = 50)

ggsave(p42, filename = "images/p42.png", dpi = 300, width = 30, height = 30)

aave_dist <- aave_final %>%
  select(starts_with("CE_ethereum_"), one_of(dem_vars)) %>%
  mutate(across(everything(), as.numeric)) %>%
  select(1:10)

aave_maha <- mahalanobis(aave_dist, colMeans(aave_dist), cov(aave_dist))

aave_final %>%
  mutate(ID = 1:nrow(.)) %>%
  select(ID) %>%
  cbind(Distance = aave_maha) %>%
  arrange(desc(Distance)) %>%
  slice(1:1000) %>%
  mutate(ID = factor(ID, levels = ID)) %>%
  ggplot(aes(x = ID, y = Distance, group = 1)) +
  geom_point() +
  geom_line() +
  scale_y_log10(breaks = c(50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000, 50000)) +
  scale_x_discrete(breaks = as.character(c(seq(1, 1000, by = 100)))) +
  labs(
    title = "Mahalanobis Distance for each observation",
    subtitle = "For the top 1000 addresses"
  )


###
# Part Five: PCA
###

aave_pca <- aave_final %>%
  select(starts_with("CE_ethereum_"), one_of(dem_vars)) %>%
  mutate(across(everything(), as.numeric))
aave_pca[is.na(aave_pca)] <- 0


my_pca <- prcomp(aave_pca)

ggpairs(my_pca$x[,1:6] %>% as_tibble)

my_tsne <- tsne(my_pca$x[,1:6] %>% as_tibble %>% slice(1:2000))
names(my_tsne) <- c("dim1", "dim2")

ggplot(my_tsne %>% as_tibble, aes(x = V1, y = V2)) +
  geom_point()
