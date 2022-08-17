{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
module Main where

import Control.Monad.Logger
import Data.Pool
import Database.Persist.Postgresql
import Yesod

newtype App = App { appConnectionPool :: Pool SqlBackend }

mkYesod "App" [parseRoutes|
/ HomeR GET
|]

instance Yesod App

instance YesodPersist App where
  type YesodPersistBackend App = SqlBackend
  runDB action = do
    pool <- getsYesod appConnectionPool
    runSqlPool action pool

getHomeR :: Handler ()
getHomeR = pure ()

main :: IO ()
main = runStderrLoggingT $ do
  pool <- createPostgresqlPool "host=localhost port=5432 dbname=yesodapp" 10
  lift $ warp 3000 $ App pool