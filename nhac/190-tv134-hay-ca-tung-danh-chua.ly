% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = "Hãy Ca Tụng Danh Chúa"
  composer = "Tv. 134"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  a4. g8 f a |
  bf2. |
  bf4. a8 g bf |
  c2 d4 |
  bf4. c8 c a |
  g2 g8 a |
  a4. c8 e, g |
  f2. \bar "||" \break
  
  f4. g8 e (d) |
  c4. c8 e f |
  \slashedGrace { a16 ( } g2) bf8 d |
  c4. g8 bf a |
  d,4. g8 f d |
  c2 c4 |
  a'4. f8 f a |
  bf4 r8 g d' c |
  c4. e,8 g c, |
  f2. \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  f4. e8 d f |
  g2. |
  g4. f8 e g |
  a2 bf4 |
  g4. a8 g f |
  e2 e8 e |
  f4. e8 c bf |
  a2.
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Hãy ca tụng danh Chúa,
  hỡi bao người tôi tớ,
  ứng trực trong cung điện Ngài,
  tại khuôn viên thánh điện Chúa ta.
  <<
    {
      \set stanza = "1."
      Hãy tán tụng Ngài vì Ngài nhân ái,
      Đàn hát lên mừng thánh danh Ngài,
      thánh danh ngọt ngào.
      Vì Chúa chọn nhà Gia -- cóp,
      Dánh Ít -- ra -- en làm sản nghiệp riêng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Tôi biết rõ rằng Ngài thực cao cả,
	    Thượng Đế ta vượt hết chư thần, tác sinh muôn loài:
	    Trời đất ngàn trùng xa cách,
	    Lòng biển bao la và đáy vực sâu.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Từ cuối chân trời Ngài đẩ  mây tới,
	    Xẹt chớp lên, thổi gió tung hoành
	    khiên mưa tuôn trào.
	    Ngài đã triệt hạ bao nước,
	    Diệt các quân vương mạnh mẽ quyền uy.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Thực Thánh Danh Ngài trường tồn muôn kiếp,
	    Ở khắp nơi và đến muôn đời vẫn tuyên xưng hoài.
	    Ngài sẽ xử trị ngay chính,
	    Thành tín yêu thương tôi tớ Ngài luôn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Kìa các tượng thần là vàng bạc đó,
	    Là bởi tay người thế tạo thành,
	    cứ im hơi hoài,
	    Dù có miệng mà không nói,
	    Cặp mắt như đui, tai đó nào nghe.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
	    Mong những kẻ nào tạc ra tượng đó,
	    Và những ai phục bái tôn thờ giống y như vậy.
	    Còn kẻ hằng cậy tin Chúa,
	    Từ khắp Si -- on hoan chúc Ngài đi.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 15\mm
  bottom-margin = 15\mm
  left-margin = 10\mm
  right-margin = 10\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  %page-count = #1
}

TongNhip = {
  \key f \major \time 3/4
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
    \override Lyrics.LyricSpace.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
