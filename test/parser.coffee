expect = require('chai').expect
parser = require '../dist/parser'

describe 'TagDataParser', ->
  describe '#parse()', ->
    it 'returns a tag data object', ->
      expect(parser.parse('ruby:2.1.2 rails:3.x,4.x')).to.deep.equal([
        {
          name: 'ruby'
          versions: ['2.1.2']
        }
        {
          name: 'rails'
          versions: ['3.x', '4.x']
        }
      ])

    it 'accepts multi bytes tag name and versions', ->
      expect(parser.parse('タグ1 タグ2:バージョン1,バージョン2')).to.deep.equal([
        {
          name: 'タグ1'
          versions: []
        }
        {
          name: 'タグ2'
          versions: ['バージョン1', 'バージョン2']
        }
      ])

    it 'accepts version with spaces', ->
      expect(parser.parse('tag:version,\\ with\\ space')).to.deep.equal([
        {
          name: 'tag'
          versions: ['version', ' with space']
        }
      ])

    it 'accepts version with backslashes', ->
      expect(parser.parse('tag:back\\\\slash')).to.deep.equal([
        {
          name: 'tag'
          versions: ['back\\slash']
        }
      ])
