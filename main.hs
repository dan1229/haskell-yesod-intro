{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
module Main where

import Control.Monad.Logger
import Data.Pool
import Database.Persist.Postgresql
import Yesod


newtype AppSettings = AppSettings { jwt :: String }
newtype App = App { appConnectionPool :: Pool SqlBackend, appSettings :: AppSettings }


mkYesod "App" [parseRoutes|
/ HomeR GET
|]

    
instance Yesod App


class Monad (YesodDB site) => YesodPersist site where
    type YesodPersistBackend site
    runDB :: YesodDB site a -> HandlerFor site a


instance YesodPersist App where
  type YesodPersistBackend App = SqlBackend
  runDB action = do
    pool <- getsYesod appConnectionPool
    runSqlPool action pool


getHomeR :: Handler ()
getHomeR = pure ()


main :: IO ()
main = runStderrLoggingT $ do
  appSettings <- loadAppSettingsArgs [configSettingsYml] [] useEnv
  pool <- createPostgresqlPool "host=localhost port=5432 dbname=yesodapp" 10
  lift $ warp 3000 $ App pool appSettings