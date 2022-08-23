{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
module Foundation where

import Data.Pool
import Database.Persist.Postgresql
import Yesod
import Settings


mkYesodData "App" [parseRoutes|
/ HomeR GET
|]


instance YesodPersist App where
  type YesodPersistBackend App = SqlBackend
  runDB action = do
    pool <- getsYesod appConnectionPool
    runSqlPool action pool


instance HasAppSettings (HandlerFor App) where
  getAppSettings = getsYesod appSettings

instance HasJwt (HandlerFor App) where
  getJwt = getsAppSettings jwt


data App = App { appConnectionPool :: ConnectionPool, appSettings :: AppSettings }
-- data App = App { appConnectionPool :: Pool SqlBackend, appSettings :: AppSettings }

    
instance Yesod App
