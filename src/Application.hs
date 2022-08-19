{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
module Application where

import Control.Monad.Logger
import Database.Persist.Postgresql
import Yesod
import Yesod.Default.Config2
import Foundation


-- mkYesodDispatch "App" resourcesApp

getHomeR :: Handler ()
getHomeR = pure ()


appMain :: IO ()
appMain =  do
  appSettings <- loadAppSettings [configSettingsYml] [] useEnv
  pool <- runStderrLoggingT $ createPostgresqlPool "host=localhost port=5432 dbname=yesodapp" 10
  warp 3000 $ App pool appSettings
--   args <- getArgs
--   case args of
--     ["--help"] -> putStrLn usage
--     ["--version"] -> putStrLn version
--     ["--license"] -> putStrLn license