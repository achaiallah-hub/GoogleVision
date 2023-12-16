#package_google vision----
library(imgrec)


#set up gvision
Sys.setenv(gvision_key = "XXX") #Your Google API Key
gvision_init()

#wikiloc_images_URL
#search google vision
results <- get_annotations(images = paste(flickrphoto$url), # image url
                           features = "label", # request all available features
                           max_res = 20, # maximum number of results per feature
                           mode = 'url') # determine image type

#parse results
temp_file_path <- tempfile(fileext = '.json')
save_json(results, temp_file_path)
img_data <- parse_annotations(results)
vision_results <- img_data$labels

#save the outputs
library("writexl")
write_xlsx(vision_results,"vision_flickr.xlsx")


#work with vision
#summary description
vision_summary <- data.frame(table(vision_results$description))
vision_summary <- vision_summary[order(-vision_summary$Freq),]
head(vision_summary)