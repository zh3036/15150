# def foo(n):
# 	return lambda i:i+n

def foo2 (n):
	s = [n]
	def bar (i):
		s[0] += i
		return s[0]
	return bar