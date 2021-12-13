% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Chúa Nổi Giận Mãi sao"
  composer = "Tv. 78"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 f16 e |
  d4. d8 |
  a'4 \tuplet 3/2 { f8
  <<
    {
      \voiceOne
      f
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #2
      \parenthesize
      g
    }
  >>
  \oneVoice
  a } |
  e4 \tuplet 3/2 { a8 a d } |
  g,4. bf8 |
  a4 r8 bf16 g |
  e4. e8 |
  \tuplet 3/2 { g8 f f } \tuplet 3/2 { a8 e c } |
  \partial 4 d4 \bar "||"
  
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key d \major
  \partial 8 a'8 |
  fs4. fs8 |
  d e4 fs8 |
  g2 |
  fs8 a4 b8 |
  b4 r8 cs |
  cs8. d16 a8 fs |
  g4. b8 |
  b8. b16 e,8 g |
  a a4 e8 |
  d2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*7
  r4
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key d \major
  cs8 |
  d4. d8 |
  b cs4 d8 |
  e2 |
  d8 fs4 g8 |
  g4 r8 a |
  a8. g16 fs8 d |
  e4. g8 |
  g8. e16 cs8 b |
  cs cs4 cs8 |
  d2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Đến bao giờ, lạy Chúa, Ngài con nổi giận,
      Ngài con nổi giận mãi sao?
      Đến bao giờ lòng ghen còn bừng cháy như lửa hồng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Nhớ chi hoài tội lỗi tiền
	    \markup { \italic \underline "nhân" }
	    đã phạm
	    Để rồi đánh phạt chúng cong.
	    Đớn đau nhiều, đoàn con nguyện Ngài đứng lên độ trì.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Hãy bang trợ, lạy Chúa, nguồn
	    \markup { \italic \underline "ơn" }
	    cứu độ, Nguyện Ngài dủ tình thứ tha
	    Thánh danh Ngài ngàn năm còn rạng rỡ vinh hiển luôn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Ước mong hoài, lạy Chúa được nhìn nhãn tiền
	    Ngài làm dân ngoại thấy ngay:
	    Chúng phải đền nợ máu mà bọn chúng đã đổ ra.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Lớp dân này, lạy Chúa thực là của Ngài,
	    là đàn chiên ngài dắt chăn,
	    Chúng con cùng tạ ơn và ngàn kiếp xin ngợi ca.
    }
  >>
  \set stanza = "ĐK:"
  Ước chi tiếng tù nhân rên xiết
  vọng lên tới Chúa.
  Xin vung cánh tay hùng mạnh cứu sống
  những người bị kết án tử hình.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 10\mm
  bottom-margin = 10\mm
  left-margin = 10\mm
  right-margin = 10\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  page-count = 1
}

TongNhip = {
  \key f \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -3 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #0.6
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
