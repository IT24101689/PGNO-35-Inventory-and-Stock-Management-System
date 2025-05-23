package utils;

import java.util.ArrayList;
import java.util.EmptyStackException;

public class CustomStack<T> implements Stack<T> {
    private ArrayList<T> stackList;

    public CustomStack() {
        stackList = new ArrayList<>();
    }

    public void push(T item) {
        stackList.add(item);
    }

    public T pop() {
        if (isEmpty()) throw new EmptyStackException();
        return stackList.remove(stackList.size() - 1);
    }

    public T peek() {
        if (isEmpty()) throw new EmptyStackException();
        return stackList.get(stackList.size() - 1);
    }

    public boolean isEmpty() {
        return stackList.isEmpty();
    }

    public int size() {
        return stackList.size();
    }

    public ArrayList<T> getRemainingItems() {
        return new ArrayList<>(stackList);
    }
}
