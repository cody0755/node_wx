wx = require __basename + '/helpers/wx/wx'
http = require 'http'

module.exports = (app) ->

  app.post '/wx/login', (req, res) ->
    msg = req.body.msg
    fakeid = req.body.fakeid
    wx.login req, (err, results) ->
      req.session.is_login = results if results
      res.json err if err
      data =
        msg : msg
        fakeid : fakeid
        cookie : results.cookie
        token : results.token

      wx.sender req, data, (err, results) ->
        res.json err if err
        res.json results