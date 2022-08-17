module Settings where


newtype AppSettings = AppSettings { jwt :: String }


getsAppSettings :: HasAppSettings m => (AppSettings -> a) -> m a
getsAppSettings f = f <$> getAppSettings 

class HasAppSettings m where
    getAppSettings :: m AppSettings

class HasJwt m where
    getJwt :: m String