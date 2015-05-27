require 'rspec'
require_relative '../model/char_counter.rb'

describe 'CharCounter' do
  
  it 'should return {a=>1} when string is a' do
    dic = CharCounter.count('a')
    dic['a'].should be 1
  end

  it 'should return {b=>nil} when string is a' do
    dic = CharCounter.count('a')
    dic['b'].should be nil
  end  
  
  it 'should return {a=>2,t=>1,d=>1,0=>1 } when string is atado' do
    dic = CharCounter.count('atado')
    dic['a'].should be 2
    dic['t'].should be 1
    dic['d'].should be 1
    dic['o'].should be 1
  end  

  it 'should return {a=>2,t=>1,d=>1,0=>1 } when string is ata do' do
    dic = CharCounter.count('ata do')
    dic['a'].should be 2
    dic['t'].should be 1
    dic['d'].should be 1
    dic['o'].should be 1
    dic.size.should be 4
  end

  it 'should return {} when string is empty' do
    dic = CharCounter.count('')
    dic.size.should be 0
  end    

  it 'should return {} when string is nil' do
    dic = CharCounter.count(nil)
    dic.size.should be 0
  end    

  it 'prueba para probar travis' do
     dic = CharCounter.count('')
     dic.size.should be 0
  end

end
