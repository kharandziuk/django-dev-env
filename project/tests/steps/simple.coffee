assert = require 'assert'
module.exports = ()->
  @Given /^I visit emulator page$/, ->
    @driver.get('http://localhost:8000/')

  @Given /^clean profiles$/, ->
    @Widget.find(root: 'body').then((widget)->
      widget.click('#btn-clean-profiles')
    )

  @Given /^create new$/, ->
    @Widget.find(root: 'body').then((widget)->
      widget.click('#btn-create')
    )
  
  @Given /^choose the profile$/, ->
    @Widget.find(root: 'body').then((widget)->
      widget.findAll('li').then((list)->
        list.items().should.eventually.have.length(1)
        list.click('li')
      )
    )
