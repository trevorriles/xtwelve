{-# LANGUAGE OverloadedStrings #-}
-- | 

module X12.Parser where
import Data.Text hiding (count)
import Data.Attoparsec.Text

type Element = Text

testFile :: Text
testFile = "ISA*01*0000000000*01*ABCCO     *12*4405197800     *01*999999999      *101127*1719*U*00400*000003438*0*P*>"

testFail :: Text
testFail = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><note><to> Tove</to><from>Jani</from><body>Don't forget me this weekend!</body></note>"

sepChar :: Char
sepChar = '*'

segmentIdParser :: Parser Element
segmentIdParser = do
  sid <- count 3 letter
  return $ pack sid

segmentParser :: Parser [Element]
segmentParser = do
  sid <- segmentIdParser
  char sepChar
  return [sid]
