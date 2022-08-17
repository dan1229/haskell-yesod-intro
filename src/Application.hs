
module Application where

import Control.Monad.Logger
import Database.Persist.Postgresql
import Yesod


mkYesodDispatch "App" resourcesApp

    
getHomeR :: Handler ()
getHomeR = pure ()


appMain :: IO ()
appMain = runStderrLoggingT $ do
  appSettings <- loadAppSettingsArgs [configSettingsYml] [] useEnv
  pool <- createPostgresqlPool "host=localhost port=5432 dbname=yesodapp" 10
  lift $ warp 3000 $ App pool appSettings
--   args <- getArgs
--   case args of
--     ["--help"] -> putStrLn usage
--     ["--version"] -> putStrLn version
--     ["--license"] -> putStrLn license