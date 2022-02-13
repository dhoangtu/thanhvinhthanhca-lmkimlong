% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Nghe Về Chúa" }
  composer = "Hc. 3,2-4.13a.15-19"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \autoPageBreaksOff
  \partial 8 c8 |
  a'4. a16 bf |
  a8 g f f |
  bf4 r8 bf |
  a4. f16 f |
  f8 f g a |
  e4 r8 f16 e |
  d8 d c a' |
  a4. a16 a |
  a8 g f f |
  bf4 r8 bf16 c |
  e,8 d c g' |
  f4 r8 \bar "|." \break
  
  c16 c |
  a'8 f f bf |
  bf4 \tuplet 3/2 { c8 c bf } |
  a8 c, a'16 (bf) a8 | \pageBreak
  g4 r8 g16 f |
  f8 e a e |
  d4. d16
  <<
    {
      \voiceOne
      e16
    }
    \new Voice = "beSop" {
      \voiceTwo
      \stemDown
      \once \override NoteColumn.force-hshift = #1
      \parenthesize
      d
    }
  >>
  \oneVoice
  c8 f e f |
  \slashedGrace { a16 ( } g4) r8 \bar "||"
}

nhacPhienKhucAlto = \relative c' {
  c8 |
  f4. f16 g |
  f8 e d c |
  g'4 r8 g |
  f4. d16 d |
  d8 d e d |
  cs4 r8 d16 a |
  b!8 b c e |
  f4. f16 f |
  f8 e d c |
  g'4 r8 d16 d |
  c8 bf a bf |
  a4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Lạy Chúa con đã nghe loan truyền về Chúa, Chúa ơi,
  sự nghiệp Ngài lòng con kính sợ,
  Qua mọi thời xin hằng tái diễn
  Cho muôn dân thiên hạ đều biết,
  Trong nghĩa nộ xin Ngài xót thương.
  <<
    {
      \set stanza = "1."
      Ngài ngự giá từ miền Tê -- man,
      Đức Thánh quang lâm từ núi Pa -- ran,
      Bóng uy phong rợp chín cung trời,
      Câu tán tụng van mười phương đất.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Ngài rực rỡ tựa làn ánh sáng,
	    nắm vững trong tay quyền phép huy phong,
	    Chúa thân chinh giải cứu dân Ngài,
	    và Đấng được xức dầu của Chúa.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Ngài mở lối để đoàn chiến mã tiến
	    giữa phong ba biển cả mênh mông.
	    Mới nghe qua lòng rối bời bời,
	    nghe thoáng mà môi miệng run rẩy.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Lòng bình tĩnh đợi ngày khốn quẫn
	    trút xuống trên dân hà hiếp chúng tôi,
	    Dẫu cho nay mục nát xương rồi,
	    chân rã rời không còn vững bước.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Tìm chẳng thấy một quả ô -- liu,
	    kiếm khắp nương nho một trái không ra,
	    Lũ chiên dê đã biến khỏi ràn,
	    Trông đến chuồng bê bò đâu hết.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
	    Lòng này reo mừng vì Chúa mãi,
	    Vẫn sướng vui luôn vì Đấng cứu tôi,
	    Chúa cho tôi mạnh sức, lanh lẹ,
	    Như \markup { \italic \underline "nai" }
	    vượt lên tận đỉnh núi.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2.5))
  ragged-bottom = ##t
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
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
