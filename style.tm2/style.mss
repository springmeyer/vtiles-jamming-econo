

@land: #f4efe1;
@water: #cdd;
@water_dark: #185869;

#water {
  polygon-fill:@water_dark;
  ::blur {
      image-filters-inflate:true;
      image-filters:agg-stack-blur(6,6);
      polygon-fill:@water;
  }  
}

Map  {
  background-color:@land;
}































