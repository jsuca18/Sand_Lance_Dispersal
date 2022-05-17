
%spatial plotting of connectivity example
%JJS
clear all
clc
close all
%% creat Wilkinson Basin Polygon and obtain particle locations
cd 'D:\Sand_Lance_Dispersal_Modeling\data_files'
addpath('D:\Sand_Lance_Dispersal_Modeling\gif_v1.0\gif');
addpath 'D:\Sand_Lance_Dispersal_Modeling\data_files\sp_proj';
%%
%where my mapping tools are
addpath 'D:\Arctic';
addpath 'D:\m_map1.4i';
%%
cd 'D:\Sand_Lance_Dispersal_Modeling\data_files'

load GOM3_grid.mat
load Stellwagen_Particle_Locations.mat

x_gom3 = mGRID.x;
y_gom3 = mGRID.y;
h_gom3 = mGRID.h;

lon_gom3 = mGRID.lon;
lat_gom3 = mGRID.lat;

load GOM3_coast.mat
load xy_coastline.mat

cd 'D:\Sand_Lance_Dispersal_Modeling\Connection_Retention_Results\Corrected_Spatial_Data';
addpath 'D:\Sand_Lance_Dispersal_Modeling\Matlab_Code';
%loading in .mat files of connectivity (equivalent of csvs of connectivity
%locations
load Stell_GB_Forward_Space.mat
load Stell_GSC_Forward_Space.mat
load Stell_Stell_Forward_Space.mat
load Stell_GB_Backward_Space.mat
load Stell_GSC_Backward_Space.mat
load Stell_Stell_Backward_Space.mat
load Stell_Polygon.mat
load Stell_NW_Corner_Polygon.mat
load Stell_SW_Corner_Polygon.mat
load Stell_Central_Polygon.mat
load Stell_NW_Corner_Polygon.mat
load Stell_SW_Corner_Polygon.mat
load Stell_Central_Polygon.mat

%in this case, coordinates need to be convert to lat lon
[SB_Poly_Lon, SB_Poly_Lat]=sp_proj('1802','inverse',Stell_Polygon(:,1),Stell_Polygon(:,2),'m');
addpath 'D:\Sand_Lance_Dispersal_Modeling\data_files\mygeodata'

% ETOPO-1 bathymetry
 file = 'exportimage_NE.nc';
 [LAT,LON] = meshgrid(ncread(file,'lat'),ncread(file,'lon'));
 z = double(ncread(file,'Band1'));
%%
cd 'D:\Sand_Lance_Dispersal_Modeling\Connection_Retention_Results\Spatial_Connection_Figures'
figure(4)
set(gcf,'color','w');
%add in filled-in US states
states = shaperead('usastatehi', 'UseGeoCoords', true);
geoshow(states, 'DefaultFaceColor', 'black', ...
                'DefaultEdgeColor', 'black');
            hold on
CL=shaperead('D:\Sand_Lance\Sandlance Mapping Code-20200211T181943Z-001\Sandlance Mapping Code\PROVINCE.SHP')
mapshow(CL,'FaceColor', 'black', ...
                'DefaultEdgeColor', 'black');
            
geoshow(states, 'FaceColor', 'black')
hold on
%convert connectivity to percentages
caxis([0 max(Spatial_Mean_Stell_Stell_For)*100])
colormap default
c=colorbar();
c.Label.String = 'Connectivity Metric (%)';
c.Label.FontSize = 16;
c.FontSize=14;
c.FontWeight='bold';
hold on
scatter(Stell_Lon_Use,Stell_Lat_Use, 15, (Spatial_Mean_Stell_Stell_For)*100,'filled');
hold on 
contour(LON,LAT,z,[-100 -100],'-','color',[0.2 0.2 0.2])
hold on
plot(SB_Poly_Lon, SB_Poly_Lat, 'b-','LineWidth',2.5)

xlim([-70.6 -69.9])
ylim([42 42.5])
title('Stellwagen', 'FontSize',14, 'FontWeight','bold')
xlabel("Longitude",'FontSize',14, 'FontWeight','bold')
ylabel("Latitude", 'FontSize',14, 'FontWeight','bold')
box on
cd 'D:\Sand_Lance_Dispersal_Modeling\Ch3_Manuscript\Revisions\Figures\Stell'

print('-f4','Forward_Stellwagen_Stell_Space_220209','-dtiff','-r300')
