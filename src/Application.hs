{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -Wno-orphans #-}
module Application where

import Control.Monad.Logger
import Database.Persist.Postgresql
import Yesod
import Yesod.Default.Config2
import Foundation

mkYesodDispatch "App" resourcesApp

getHomeR :: Handler ()
getHomeR = pure ()


appMain :: IO ()
appMain = runStderrLoggingT $ do
  currAppSettings <- liftIO $ loadYamlSettings [configSettingsYml] [] useEnv
  pool <-  createPostgresqlPool "host=localhost port=5432 dbname=yesodapp" 10
  liftIO $ warp 3000 $ App pool currAppSettings
  