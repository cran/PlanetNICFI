## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(fig.width = 6,
                      fig.height = 6, 
                      fig.align = "center",
                      warning = FALSE, 
                      message = FALSE,
                      echo = TRUE,
                      eval = FALSE)

## -----------------------------------------------------------------------------
#  
#  wkt_file = system.file('data_files/Sugar_Cane_Bolivia.wkt', package = "PlanetNICFI")
#  WKT = readLines(wkt_file, warn = FALSE)
#  WKT
#  

## -----------------------------------------------------------------------------
#  
#  api_key = 'use_your_planet_nicfi_API_key_here'
#  

## -----------------------------------------------------------------------------
#  
#  require(PlanetNICFI)
#  
#  mosaic_files = nicfi_mosaics(planet_api_key = api_key,
#                               type = 'bi_annually',
#                               crs_bbox = 4326,
#                               URL = 'https://api.planet.com/basemaps/v1/mosaics',
#                               verbose = FALSE)
#  
#  dtbl = mosaic_files$dtbl_mosaic
#  colnames(dtbl)
#  

## -----------------------------------------------------------------------------
#  
#  cols_keep = c('id', 'first_acquired', 'last_acquired')
#  dtbl_keep = dtbl[, ..cols_keep]
#  dtbl_keep
#  

## -----------------------------------------------------------------------------
#  
#  index_year_2016 = 1
#  mosaic_ID_2016 = dtbl_keep$id[index_year_2016]
#  
#  quad_files = nicfi_quads_bbox(planet_api_key = api_key,
#                                mosaic_id = mosaic_ID_2016,
#                                bbox_AOI = NULL,
#                                wkt_AOI = WKT,
#                                page_size = 10,
#                                crs_bbox = 4326,
#                                verbose = FALSE)
#  
#  dtbl_quads = quad_files$quads
#  colnames(dtbl_quads)
#  

## -----------------------------------------------------------------------------
#  
#  cols_keep_quads = c('id_quad_page', 'quad_link_download', 'quad_link_thumbnail')
#  dtbl_keep_quads = dtbl_quads[, ..cols_keep_quads]
#  dtbl_keep_quads[, 'id_quad_page']
#  

## -----------------------------------------------------------------------------
#  
#  url_paths_2016 = aria2c_download_paths(mosaic_output = mosaic_files,
#                                         mosaic_id = mosaic_ID_2016,
#                                         quads_output = quad_files,
#                                         img_type = 'thumbnail')
#  
#  url_paths_2016
#  

## -----------------------------------------------------------------------------
#  
#  temp_dir_out = tempdir()
#  temp_dir_out
#  

## -----------------------------------------------------------------------------
#  
#  all_threads = parallel::detectCores()
#  set_threads = length(url_paths_2016) / 2
#  num_threads = ifelse(set_threads < all_threads, set_threads, all_threads)
#  aria_args = '--allow-overwrite --file-allocation=none --retry-wait=5 --max-tries=0'
#  
#  res_downl = aria2c_bulk_donwload(vector_or_file_path = url_paths_2016,
#                                   default_directory = temp_dir_out,
#                                   threads = num_threads,
#                                   verbose = FALSE,
#                                   secondary_args_aria = aria_args)
#  

## -----------------------------------------------------------------------------
#  
#  url_paths_2016_tif = aria2c_download_paths(mosaic_output = mosaic_files,
#                                             mosaic_id = mosaic_ID_2016,
#                                             quads_output = quad_files,
#                                             img_type = 'tif')
#  
#  res_downl_tif = aria2c_bulk_donwload(vector_or_file_path = url_paths_2016_tif,
#                                       default_directory = temp_dir_out,
#                                       threads = num_threads,
#                                       verbose = FALSE,
#                                       secondary_args_aria = aria_args)

## -----------------------------------------------------------------------------
#  
#  #..................................................................
#  # create a Virtual Raster (VRT) file from the downloaded .tif files
#  #..................................................................
#  
#  VRT_out = file.path(temp_dir_out, glue::glue("{mosaic_ID_2016}.vrt"))
#  
#  res_vrt = create_VRT_from_dir(dir_tifs = temp_dir_out,
#                                output_path_VRT = VRT_out,
#                                file_extension = '.tif',
#                                verbose = TRUE)
#  
#  
#  #.......................................................
#  # Adjust the Coordinate Reference System of the bounding
#  # box from 4326 to the projection of the .tif files
#  #.......................................................
#  
#  wkt_sf = sf::st_as_sfc(WKT, crs = 4326)
#  crs_value = gdalUtils::gdalsrsinfo(VRT_out, as.CRS = TRUE)
#  proj_info = crs_value@projargs
#  if (is.na(proj_info)) {
#    stop("The 'gdalUtils::gdalsrsinfo' returned an NA! 'proj4' is not available in your OS!")
#  }
#  
#  wkt_transf = sf::st_transform(wkt_sf, crs = proj_info)
#  bbx_transf = sf::st_bbox(wkt_transf)
#  
#  
#  #..............................................................................
#  # crop the output .vrt file based on the bounding box and save the output image
#  #..............................................................................
#  
#  pth_crop_out = file.path(temp_dir_out, glue::glue("{mosaic_ID_2016}_CROPPED.tif"))
#  
#  bbx_crop = list(xmin = as.numeric(bbx_transf['xmin']),
#                  xmax = as.numeric(bbx_transf['xmax']),
#                  ymin = as.numeric(bbx_transf['ymin']),
#                  ymax = as.numeric(bbx_transf['ymax']))
#  
#  warp_obj = nicfi_crop_images(input_pth = VRT_out,
#                               output_pth = pth_crop_out,
#                               bbox_AOI = bbx_crop,
#                               threads = num_threads,
#                               of = 'GTiff',
#                               resize_method = 'lanczos',
#                               verbose = TRUE)

## -----------------------------------------------------------------------------
#  
#  index_year_2018 = 5
#  mosaic_ID_2018 = dtbl_keep$id[index_year_2018]
#  
#  quad_files_2018 = nicfi_quads_bbox(planet_api_key = api_key,
#                                     mosaic_id = mosaic_ID_2018,
#                                     bbox_AOI = NULL,
#                                     wkt_AOI = WKT,
#                                     page_size = 10,
#                                     crs_bbox = 4326,
#                                     verbose = FALSE)
#  
#  url_paths_2018 = aria2c_download_paths(mosaic_output = mosaic_files,
#                                         mosaic_id = mosaic_ID_2018,
#                                         quads_output = quad_files_2018,
#                                         img_type = 'tif')
#  
#  #.....................................................................
#  # create a new temporary directory to save the .tif files of year 2018
#  #.....................................................................
#  
#  temp_dir_2018 = file.path(temp_dir_out, 'year_2018')
#  if (!dir.exists(temp_dir_2018)) dir.create(temp_dir_2018)
#  
#  res_downl_tif_2018 = aria2c_bulk_donwload(vector_or_file_path = url_paths_2018,
#                                            default_directory = temp_dir_2018,
#                                            threads = num_threads,
#                                            verbose = FALSE,
#                                            secondary_args_aria = aria_args)
#  
#  VRT_out_2018 = file.path(temp_dir_2018, glue::glue("{mosaic_ID_2018}.vrt"))
#  
#  res_vrt = create_VRT_from_dir(dir_tifs = temp_dir_2018,
#                                output_path_VRT = VRT_out_2018,
#                                file_extension = '.tif',
#                                verbose = TRUE)
#  
#  pth_crop_2018 = file.path(temp_dir_2018, glue::glue("{mosaic_ID_2018}_CROPPED.tif"))
#  
#  warp_obj = nicfi_crop_images(input_pth = VRT_out_2018,
#                               output_pth = pth_crop_2018,
#                               bbox_AOI = bbx_crop,
#                               threads = num_threads,
#                               of = 'GTiff',
#                               resize_method = 'lanczos',
#                               verbose = TRUE)
#  

## -----------------------------------------------------------------------------
#  
#  orig_rst = raster::brick(x = pth_crop_2018)        # image 2018: origin or reference
#  change_rst = raster::brick(x = pth_crop_out)       # image 2016
#  
#  bands = c(1, 5)                                    # bands 1 and 5 depict the difference better
#  
#  cva = RStoolbox::rasterCVA(x = orig_rst[[bands]], y = change_rst[[bands]])
#  

## -----------------------------------------------------------------------------
#  
#  sp::plot(cva$angle, axes = F)
#  

