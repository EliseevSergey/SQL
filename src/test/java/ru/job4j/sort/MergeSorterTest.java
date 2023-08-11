package ru.job4j.sort;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.junit.jupiter.api.Assertions.*;

class MergeSorterTest {
    @Test
    public void thenFromStartToEnd() {
        MergeSorter mergeSorter = new MergeSorter();
        int[] in = {5, 2, 4, -6, 1, 3, 2, 6, 0};
        int[] expected = {-6, 0, 1, 2, 2, 3, 4, 5, 6};
        assertArrayEquals(expected, mergeSorter.sort(in));
    }

    @Test
    public void whenSingle() {
        MergeSorter mergeSorter = new MergeSorter();
        int[] in = {333};
        int[] expected = {333};
        assertArrayEquals(expected, mergeSorter.sort(in));
    }

    @Test
    public void whenEmptyOrNullThenThrow() {
        MergeSorter mergeSorter = new MergeSorter();
        int[] empty = {};
        int[] nothing = null;
        assertThatThrownBy(() -> mergeSorter.sort(empty))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessageContaining("Array length is 0");

        assertThatThrownBy(() -> mergeSorter.sort(nothing))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessageContaining("Array is null");
    }
}