module LazyZ3
  module Int
    def +(rhs)
      if rhs.is_a?(Z3Node)
        ss(:send, :+, ss(:const, self), rhs)
      else
        super(rhs)
      end
    end

    def -(rhs)
      if rhs.is_a?(Z3Node)
        ss(:send, :-, ss(:const, self), rhs)
      else
        super(rhs)
      end
    end

    def *(rhs)
      if rhs.is_a?(Z3Node)
        ss(:send, :*, ss(:const, self), rhs)
      else
        super(rhs)
      end
    end

    def /(rhs)
      if rhs.is_a?(Z3Node)
        ss(:send, :/, ss(:const, self), rhs)
      else
        super(rhs)
      end
    end

    def ==(rhs)
      if rhs.is_a?(Z3Node)
        ss(:send, :==, ss(:const, self), rhs)
      else
        super(rhs)
      end
    end

    def !=(rhs)
      if rhs.is_a?(Z3Node)
        ss(:send, :!=, ss(:const, self), rhs)
      else
        super(rhs)
      end
    end

    def <(rhs)
      if rhs.is_a?(Z3Node)
        ss(:send, :<, ss(:const, self), rhs)
      else
        super(rhs)
      end
    end

    def >(rhs)
      if rhs.is_a?(Z3Node)
        ss(:send, :>, ss(:const, self), rhs)
      else
        super(rhs)
      end
    end

    def <=(rhs)
      if rhs.is_a?(Z3Node)
        ss(:send, :<=, ss(:const, self), rhs)
      else
        super(rhs)
      end
    end

    def >=(rhs)
      if rhs.is_a?(Z3Node)
        ss(:send, :>=, ss(:const, self), rhs)
      else
        super(rhs)
      end
    end
  end

  module Bool
    def ==(rhs)
      if rhs.is_a?(Z3Node)
        ss(:send, :==, ss(:const, self), rhs)
      else
        super(rhs)
      end
    end

    def !=(rhs)
      if rhs.is_a?(Z3Node)
        ss(:send, :!=, ss(:const, self), rhs)
      else
        super(rhs)
      end
    end

    def &(rhs)
      if rhs.is_a?(Z3Node)
        ss(:send, :&, ss(:const, self), rhs)
      else
        super(rhs)
      end
    end

    def |(rhs)
      if rhs.is_a?(Z3Node)
        ss(:send, :|, ss(:const, self), rhs)
      else
        super(rhs)
      end
    end
  end

  def self.var_int(name)
    ss(:var_int, name)
  end

  def self.var_bool(name)
    ss(:var_bool, name)
  end

  class Z3Node < ::AST::Node
    def +(rhs)
      if rhs.is_a?(Z3Node)
        ss(:send, :+, self, rhs)
      elsif rhs.is_a?(Integer) || rhs.bool?
        ss(:send, :+, self, ss(:const, rhs))
      else
        raise LazyZ3::Error, "unhandled type"
      end
    end

    def -(rhs)
      if rhs.is_a?(Z3Node)
        ss(:send, :-, self, rhs)
      elsif rhs.is_a?(Integer) || rhs.bool?
        ss(:send, :-, self, ss(:const, rhs))
      else
        raise LazyZ3::Error, "unhandled type"
      end
    end

    def *(rhs)
      if rhs.is_a?(Z3Node)
        ss(:send, :*, self, rhs)
      elsif rhs.is_a?(Integer) || rhs.bool?
        ss(:send, :*, self, ss(:const, rhs))
      else
        raise LazyZ3::Error, "unhandled type"
      end
    end

    def /(rhs)
      if rhs.is_a?(Z3Node)
        ss(:send, :/, self, rhs)
      elsif rhs.is_a?(Integer) || rhs.bool?
        ss(:send, :/, self, ss(:const, rhs))
      else
        raise LazyZ3::Error, "unhandled type"
      end
    end

    def ==(rhs)
      if rhs.is_a?(Z3Node)
        ss(:send, :==, self, rhs)
      elsif rhs.is_a?(Integer) || rhs.bool?
        ss(:send, :==, self, ss(:const, rhs))
      else
        raise LazyZ3::Error, "unhandled type"
      end
    end

    def !=(rhs)
      if rhs.is_a?(Z3Node)
        ss(:send, :!=, self, rhs)
      elsif rhs.is_a?(Integer) || rhs.bool?
        ss(:send, :!=, self, ss(:const, rhs))
      else
        raise LazyZ3::Error, "unhandled type"
      end
    end

    def <(rhs)
      if rhs.is_a?(Z3Node)
        ss(:send, :<, self, rhs)
      elsif rhs.is_a?(Integer) || rhs.bool?
        ss(:send, :<, self, ss(:const, rhs))
      else
        raise LazyZ3::Error, "unhandled type"
      end
    end

    def >(rhs)
      if rhs.is_a?(Z3Node)
        ss(:send, :>, self, rhs)
      elsif rhs.is_a?(Integer) || rhs.bool?
        ss(:send, :>, self, ss(:const, rhs))
      else
        raise LazyZ3::Error, "unhandled type"
      end
    end

    def <=(rhs)
      if rhs.is_a?(Z3Node)
        ss(:send, :<=, self, rhs)
      elsif rhs.is_a?(Integer) || rhs.bool?
        ss(:send, :<=, self, ss(:const, rhs))
      else
        raise LazyZ3::Error, "unhandled type"
      end
    end

    def >=(rhs)
      if rhs.is_a?(Z3Node)
        ss(:send, :>=, self, rhs)
      elsif rhs.is_a?(Integer) || rhs.bool?
        ss(:send, :>=, self, ss(:const, rhs))
      else
        raise LazyZ3::Error, "unhandled type"
      end
    end

    def &(rhs)
      if rhs.is_a?(Z3Node)
        ss(:send, :&, self, rhs)
      elsif rhs.is_a?(Integer) || rhs.bool?
        ss(:send, :&, self, ss(:const, rhs))
      else
        raise LazyZ3::Error, "unhandled type"
      end
    end

    def |(rhs)
      if rhs.is_a?(Z3Node)
        ss(:send, :|, self, rhs)
      elsif rhs.is_a?(Integer) || rhs.bool?
        ss(:send, :|, self, ss(:const, rhs))
      else
        raise LazyZ3::Error, "unhandled type"
      end
    end

    def !
      ss(:send, :!, self)
    end
  end
end

class BasicObject
  def bool?
    self.is_a?(::FalseClass) || self.is_a?(::TrueClass)
  end
end
