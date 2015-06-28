require 'rails_helper'
require 'pry'

describe Job do
  
  # validations
  
  it 'is valid with a drop-off time'
  it 'is invalid without a drop-off time'
  it 'is valid with a drop-off location'
  it 'is invalid without a drop-off location'
  it 'is valid with a pup id'
  it 'is invalid without a pup id'

  # methods
  
  it 'updates pending walker'
  it 'sends walk request mailers'
  it 'updates walker upon owner approval'
  it 'sends walk request approved mailers'
  it 'updates walker upon owner denial'
  it 'sends walk denial mailers'
  it 'updates pending walker upon cancellation'
  it 'sends cancellation mailers'
  it 'send destroyed job mailer'
  
end