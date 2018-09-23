# frozen_string_literal: true

# Inheritance-root for all controllers/APIs. Here we should add all
# in common includes and methods.
class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
end
