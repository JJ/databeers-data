library(rjson)
library(stringr)
library(dplyr)
library(ggplot2)
library(ggthemes)

tickets <- fromJSON(file="data/tickets.json")

tickets.df <- data.frame( ID=character(), session=numeric(), talk=numeric())

for (i in 1:length(tickets)) {
 data <- (str_split(tickets[[i]]$value,"/"))[[1]]
 
 tickets.df <- rbind(tickets.df,
                     data.frame(ID=data[7],
                                session=data[5],
                                talk=data[6]
                                ))
}

different.IDs <- unique(tickets.df$ID)

IDs.per.session <- tickets.df %>%
  group_by(session) %>%
  summarise(n = n_distinct(ID))
  
IDs.per.talk <- tickets.df %>%
  group_by(session,talk) %>%
  summarise(n = n_distinct(ID))

IDs.per.talk$session.talk <- paste0(IDs.per.talk$session,"-",IDs.per.talk$talk)
IDs.per.talk$session.talk <- as.factor(IDs.per.talk$session.talk)
ggplot(IDs.per.talk, aes(x=reorder(session.talk,-n), y=n))+geom_bar(stat="identity")+ theme_tufte()+theme(axis.text = element_text(angle = 45))+theme(axis.text = element_text(size=30))


talks.per.ID <- tickets.df %>%
  group_by(ID) %>%
  summarise(n = n_distinct(session,talk))

talks.per.ID$idu <- as.numeric(row.names(talks.per.ID))

ggplot(talks.per.ID,aes(x=reorder(idu,-n),y=n))+geom_bar(stat="identity")+ theme_tufte()+theme(
  axis.title.x = element_blank(),
  axis.ticks.x = element_blank(),
  axis.text.x = element_blank(),
  axis.text.y = element_text(size=30))

sessions.per.ID <- tickets.df %>%
  group_by(ID) %>%
  summarise(n = n_distinct(session))

beers <- fromJSON(file="data/beers.json")

beers.df <- data.frame( ID=character(), session=numeric(), talk=numeric())
