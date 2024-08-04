terraform {
   required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
#  Migrating to cloud
  cloud {
    organization = "Vertives"
    workspaces {
      name = "terra-house-1"
    }
  }
}

provider "terratowns" {
  endpoint = "http://localhost:4567/api"
  user_uuid = var.teacherseat_user_uuid
  #user_uuid="e328f4ab-b99f-421c-84c9-4ccea042c7d1"
  token="9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  #user_uuid = var.user_uuid
  bucket_name = var.bucket_name
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  content_version = var.content_version
  assets_path = var.assets_path
}

resource "terratowns_home" "home" {
  name = "How to play Arcanum in 2023!"
  description = <<DESCRIPTION
Arcanum is a game from 2001 that shipped with alot of bugs.
Modders have removed all the originals making this game really fun
to play (despite that old look graphics). This is my guide that will
show you how to play arcanum without spoiling the plot.
DESCRIPTION
  #domain_name = module.terrahouse_aws.cloudfront_url
  domain_name = "3fdq3gz.cloudfront.net"
  town = "gamers-grotto"
  content_version = 1
}

# module "home_minions_hosting" {
#   source = "./modules/terrahouse_aws"
#   user_uuid = var.teacherseat_user_uuid
#   #user_uuid = var.user_uuid
#   bucket_name = var.bucket_name
#   index_html_filepath = var.index_html_filepath
#   error_html_filepath = var.error_html_filepath
#   content_version = var.content_version
#   assets_path = var.assets_path
# }

# resource "terratowns_home" "home_minions" {
#   name = "All about Minions"
#   description = <<DESCRIPTION
# Minions are small, yellow pill-shaped creatures which have existed since the beginning of time, evolving from single-celled organisms into beings which exist only to serve history's most evil masters, but they accidentally end up killing all their masters: rolling a Tyrannosaurus into a volcano, letting a caveman get mauled by a bear, crushing a Pharaoh and his subjects with a pyramid, and exposing Count Dracula to sunlight. They are driven into isolation after firing a cannon at Napoleon while in Russia and start a new life inside a cave, but after many years, the Minions become sad and unmotivated without a master to serve. This prompts three Minions; named Kevin, Stuart and Bob, to go out on a quest to find a new master for their brethren to follow.
# DESCRIPTION
#   #domain_name = module.terrahouse_aws.cloudfront_url
#   domain_name = "3fdq3gz.cloudfront.net"
#   town = "gamers-grotto"
#   content_version = 1
# }

