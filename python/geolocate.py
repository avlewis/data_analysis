import pandas as pd 
from tqdm import tqdm
from geopy.geocoders import  GoogleV3

#DATA IMPORT
class data_importer:

    def __init__(self, data_path, geo = False, google_key = None, update_master = False ):

        self.path = data_path

       
        self.geo = geo
        self.google_key = google_key

        if self.geo == True and self.google_key == None:
            raise Exception('Must Have Google Api Key')
        


        self.read()
        
        self.clean()

        if self.geo == True:

            self.locate()

        if update_master == True:

            self.update_master()

        else:
            self.write()

        


    def read(self):
        """ read in data from csv file """
        
        self.df = pd.read_csv(self.path, encoding = "ISO-8859-1")

       
    def clean(self):
        """ format the data """
        
        self.df.columns = self.df.columns.str.strip().str.lower().str.replace(' ', '_').str.replace('(', '').str.replace(')', '')





    def locate(self):
        """ use google api to get geographic location

            Args:
                api_key(str): google api key
                formatted_address(str): street name, house number, city, state/province, postal code

            Returns:

                (:obj:'DataFrame'): dataframe containing lon/lat data merged with original dataset

        """
        
        #CONNECT TO API
        api = GoogleV3(api_key = self.google_key)

        #INITALIZE ARRAY
        array = []

        #START GEOCODING ADDRESSES
        for i in tqdm(range(len(self.df)), desc='Geocoding Addresses'):

            
            row = self.df.iloc[i]

            #GET ADDRESS VARIABLES
            st_name = row['street_name']
            st_number = row['house_number']
            city = row['city']
            state = row['state/province']
            listing_number = row['listing_number']
            zip = row['postal_code']


            #FORMAT ADDRESS FOR API
            full_address = str("{} {},{},{},{}".format(st_number, st_name, city, state, zip))

            #TRY TO LOCATE WITH GOOGLE
            try:
                
                location = api.geocode(full_address, timeout=10)

                lat =  location.latitude
                lon = location.longitude
                

                info = [lat,lon, listing_number]

                array.append(info)

                next 

            #Go to next if you cant locate
            except:

                info = [0,0, listing_number]

                array.append(info)

                next

        #CONVERT SERIES TO DATAFRAME
        geo_data = pd.DataFrame(data = array, columns = ['lat', 'lon', 'listing_number'])
        
        #INNER JOIN DATA TO DATAFRAME
        self.df = pd.merge(self.df, geo_data, on= 'listing_number', how = 'inner')


   
    def update_master(self):
        """ merge dataframe into master dataset, drop duplicates

        this will be used to keep the master database current

        """


        #GET MASTER DATASET
        master = pd.read_csv('/home/austin/Desktop/Falcon/realestate/Falcon/Datasets/master.csv')

        #UNION DF WITH MASTER W/O DUPLICATES *** NOT WORKING
        master = pd.concat([
            master, self.df
        ], sort = True).drop_duplicates().reset_index(drop=True)

        #WRITE TO MASTER
        master.to_csv('/home/austin/Desktop/Falcon/realestate/Falcon/Datasets/master.csv')


    

    def write(self):
        """ write the dataset to a csv """
        
        self.df.to_csv('/home/austin/Desktop/Falcon/realestate/Falcon/Datasets/mls.csv')

if __name__ == "__main__":

    key = '######'
    path = '/home/austin/Desktop/Falcon/realestate/Falcon/Datasets/okclose.csv'

    test = data_importer(path , geo=True, google_key=key, update_master = False)
